import algoliasearch from "algoliasearch";

const algoliaSearch = () => {

  const inputField = document.querySelector("#search");

  if (inputField) {
    const appId = document.querySelector("meta[name='algolia-app-id']").content;
    const searchOnlyApiKey = document.querySelector("meta[name='algolia-search-only-api-key']").content;

    const client = algoliasearch(appId, searchOnlyApiKey);
    const index = client.initIndex('Argument');

    inputField.addEventListener("keyup", () => {

    const cardContainer = document.querySelector('#searchSuggestions');
      index.search(inputField.value).then((content) => {
        if (inputField.value.length === 0) {
          cardContainer.innerHTML = ""
          return
        }
    const statements = content.hits

    cardContainer.innerHTML = ""


    statements.forEach((statement, index) => {

         if (index < 5){
          const content = statement.content.slice(0, 10) + "...";
          const suggestion = `<li data-id=${statement.objectID} class=suggestion>${content}</li>`
          cardContainer.insertAdjacentHTML("beforeEnd", suggestion);

          }
    // asking the card conatiner what to put into the container and where
    const suggestions = document.querySelectorAll(".suggestion")

          // looping through the suggestions and adding event listenign so once press enter in takes to the new page
          suggestions.forEach((suggestion) => {
          suggestion.addEventListener("click", (event) => {
          window.location=window.location.origin + "/search?statement_id=" + suggestion.dataset.id
            })
          });


        })
      })
    });
  }
}
export {algoliaSearch};
