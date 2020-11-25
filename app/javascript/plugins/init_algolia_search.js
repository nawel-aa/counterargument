import algoliasearch from "algoliasearch";

const algoliaSearch = () => {

  const inputField = document.querySelector("#search");

  if (inputField) {
    const appId = document.querySelector("meta[name='algolia-app-id']").content;
    const searchOnlyApiKey = document.querySelector("meta[name='algolia-search-only-api-key']").content;

    const client = algoliasearch(appId, searchOnlyApiKey);
    const index = client.initIndex('Argument');

    inputField.addEventListener("input", () => {
      index.search(inputField.value).then((content) => {

        const cardContainer = document.querySelector('#search-result');
        // debugger
        const statements = content.hits
        statements.forEach((statement) => {

        // asking the card conatiner what to put into the container and where
        cardContainer.insertAdjacentHTML("beforeEnd", statement.content)
        })
      })
    });
  }
}
export {algoliaSearch};
