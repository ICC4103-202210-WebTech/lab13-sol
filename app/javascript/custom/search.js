// Import functions required to enable event sort buttons in search results
import { initSortButtons } from 'custom/events';

(() => {
    document.addEventListener("turbo:load", () => {
        // Look for search box, search button and main content elements
        let searchbox = document.querySelector("#search_box");
        let searchbtn = document.querySelector("#search_button");
        let main = document.querySelector("#main_content");

        // Add a listener to the search box that triggers whenever there is input
        // from the user.
        searchbox.addEventListener("input", (ev) => {
            if (!ev.target.value.length) {
                // Display the main content element
                main.style.display = "block";

                // Find current search results and remove them from the DOM
                let search_results = document.querySelector("#search_results");
                search_results.remove();
            }
        })

        // Add a click listener to the search button
        searchbtn.addEventListener("click", (ev) => {
            // Prevent the default button behavior (form submit)
            ev.preventDefault();

            // Hide the main content element
            main.style.display = "none";

            // Find a csrf-token
            const token = document.getElementsByName(
                "csrf-token"
            )[0].content;

            // Find the search results element
            let prev_main_search = document.querySelector("#search_results");
            // Remove it if it exists already
            if (prev_main_search) {
                prev_main_search.remove();
            }

            // Take search keywords from the search box
            let keywords = document.querySelector("#search_box").value;

            // Make a call to the server endpoint. The path is search, the variable is q, 
            // and then come the keywords
            // The CSRF token needs to be passed in the headers, as the SearchController inherits from
            // ApplicationController
            fetch(`/search?q=${encodeURI(keywords)}`, { method: 'GET', headers: { 'Content-Type': 'text/html', 'X-CSRF-Token': token } })
                .then((html) => {
                    html.text().then((text) => {
                        // Re-create the main page element, with search_results id
                        let main_search = document.createElement("main");
                        main_search.setAttribute("id", "search_results");
                        main_search.setAttribute("class", "col-sm-10");
                        main_search.innerHTML = text;
                        // Add the element to the DOM and insert it
                        main.parentNode.insertBefore(main_search, main);

                        // Initialize the sort buttons available in the display of search results
                        initSortButtons();
                    })
                })
                .catch((error) => {
                    console.log("Could not get the search results, sorry");
                });
        })
    })
})()