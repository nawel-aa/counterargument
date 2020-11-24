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

        // rab the li - queryselect the ul
        // parsing the json to create the displayed html
        // assigning of inner html to step 2

        console.log(content);
        // handle results however you like...

      })
    });
  }
}

export { algoliaSearch };
