import algoliasearch from "algoliasearch";

const responsiveSearch = () => {

  const inputField = document.querySelector("#counter-search");

  if (inputField) {    
    const appId = document.querySelector("meta[name='algolia-app-id']").content;
    const searchOnlyApiKey = document.querySelector("meta[name='algolia-search-only-api-key']").content;
      
    const client = algoliasearch(appId, searchOnlyApiKey);
    const index = client.initIndex('Argument');

    inputField.addEventListener("keyup", () => {
      
      const counterContainer = document.querySelector(".counter-container");
      const input = document.querySelector(".counter-search").value;
      if ( input.length > 0 ) {
        counterContainer.id = "active";
      } else {
        counterContainer.id = "counter-container";
      }

      const suggestedTitle = document.getElementById("counter-title");
      // const suggestedNickname = document.getElementById("counter-nickname");
      const counterHiddenForm = document.querySelector(".counter-hidden-field");
      const counterCard = document.querySelector(".show-argument-child-infos-counter");

      const autocompleteElement = document.querySelector('#searchSuggestions');
        index.search(inputField.value).then((content) => {
          
          const statements = content.hits

        const resultsInput = document.getElementById('counters');
        let resultsId = statements.map((statement) => {
          return statement.objectID;
        })
        resultsInput.value = JSON.stringify(resultsId);


        statements.slice(0).forEach((statement) => {
          suggestedTitle.innerHTML = `${statement.content}`
          counterHiddenForm.value = `${statement.objectID}`
          counterCard.id = statement.objectID
          // suggestedNickname.innerHTML = `${statement.nickname}` ---> The nickname isn't in the statement object and can't connect Javascript to Ruby
          });
      });
    });
  };
};

export { responsiveSearch };
