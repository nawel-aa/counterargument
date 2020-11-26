 
 // Patrick - trying to get the search on the argument show page to work - need to use an API to fetch the results. You can safely ignore all of this, it's not live anywhere
 

 // const responsiveSearch = () => {
//   addEventListener("keyup", event => {
//     const input = document.getElementById("search").value;
//     console.log(input);
//     // query select card container of the suggestion
//     // send search term to Algolia API
//     // loop through how many searches we want to display
//     // create a new html element (this is the suggestion) - creating string, putting inside a div (interpolate)
//     // 
//   });
// };
 
 const inputField = document.querySelector("#search");

  if (inputField) {
    const appId = document.querySelector("meta[name='algolia-app-id']").content;
    const searchOnlyApiKey = document.querySelector("meta[name='algolia-search-only-api-key']").content;

    const client = responsiveSearch(appId, searchOnlyApiKey);
    const index = client.initIndex('Argument');

    inputField.addEventListener("input", () => {
      index.search(inputField.value).then((content) => {

        // const list = document.querySelector('#text');
        // parsing the json to create the displayed html ---> display = JSON.parse(#text)
        // assigning of inner html to step 2
        const serachResults = document.getElementById("search_results");
        console.log(content);
        // handle results however you like...
        console.log(content.hits[0].content);
        console.log(content.hits[0].objectID);
        // serachResults.setAttribute("arg", content.hits[0].objectID);
        // serachResults.insertAdjacentHTML("afterbegin", parseInt(content.hits[0].objectID));
        // console.log(serachResults.outerHTML);
        const h2 = serachResults.getElementsByTagName("h2").item(0).innerHTML;
        const p = serachResults.getElementsByTagName("p").item(0).innerHTML;

        serachResults.getElementsByTagName("h2").item(0).innerHTML = `<%= Argument.find(${parseInt(content.hits[0].objectID)}).content unless Argument.find(${parseInt(content.hits[0].objectID)}).nil? %>`;
        serachResults.getElementsByTagName("p").item(0).innerHTML = `<%= Argument.find(${parseInt(content.hits[0].objectID)}).user.nickname unless Argument.find(${parseInt(content.hits[0].objectID)}).nil? %>`;
        // console.log(h2);
        console.log(p);
        // serachResults.innnerHtml = `<h2><%= Argument.find(${parseInt(content.hits[0].objectID)}).content unless Argument.find(${parseInt(content.hits[0].objectID)}).nil? %></h2>
        //   <p><%= Argument.find(${parseInt(content.hits[0].objectID)}).user.nickname unless Argument.find(${parseInt(content.hits[0].objectID)}).nil? %></p>`;

      })
    });
  }
}
