import algoliasearch from "algoliasearch";

const responsiveSearch = () => {

  const inputField = document.querySelector("#counter-search");

  if (inputField) {    
    const appId = document.querySelector("meta[name='algolia-app-id']").content;
    const searchOnlyApiKey = document.querySelector("meta[name='algolia-search-only-api-key']").content;
      
    const client = algoliasearch(appId, searchOnlyApiKey);
    const index = client.initIndex('Argument');

    inputField.addEventListener("keyup", () => {
      
      const input = document.querySelector(".counter-search").value;
      const suggestedTitle = document.getElementById("counter-title");
      const suggestedNickname = document.getElementById("counter-nickname");
      const counterCard = document.querySelector(".show-argument-child-infos-counter");
      // const counterCard = document.getElementById(".show-argument-child-infos-counter");

      const autocompleteElement = document.querySelector('#searchSuggestions');
        index.search(inputField.value).then((content) => {
          
          const statements = content.hits
          // console.log(statements);

        const resultsInput = document.getElementById('counters');
        let resultsId = statements.map((statement) => {
          return statement.objectID;
        })
        resultsInput.value = JSON.stringify(resultsId);


        statements.slice(0).forEach((statement) => {
          suggestedTitle.innerHTML = `${statement.content}`
          suggestedNickname.innerHTML = `${statement.objectID}`
          counterCard.id = statement.objectID
          console.log(statement);
          console.log(counterCard);
          // suggestedNickname.innerHTML = `${statement.nickname}` ---> The nickname isn't in the statement object and can't connect Javascript to Ruby
          });
      });
    });
  };
};

export { responsiveSearch };
