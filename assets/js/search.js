(function() {
    function displaySearchResults(results, store) {
        const searchResults = document.getElementById('search-results');
        if (results.length) {
            let output = '<ul class="search-results-list">';
            results.forEach(function(result) {
                const item = store[result.ref];
                output += `
                    <li class="search-result-item">
                        <h3><a href="${item.url}">${item.title}</a></h3>
                        <p>${item.content.substring(0, 150)}...</p>
                    </li>
                `;
            });
            output += '</ul>';
            searchResults.innerHTML = output;
        } else {
            searchResults.innerHTML = '<p>No results found</p>';
        }
    }

    function getQueryVariable(variable) {
        const query = window.location.search.substring(1);
        const vars = query.split('&');

        for (let i = 0; i < vars.length; i++) {
            const pair = vars[i].split('=');

            if (pair[0] === variable) {
                return decodeURIComponent(pair[1].replace(/\+/g, '%20'));
            }
        }
    }

    const searchTerm = getQueryVariable('query');

    if (searchTerm) {
        document.getElementById('search-box').setAttribute("value", searchTerm);

        fetch('/assets/js/search-data.json')
            .then(response => response.json())
            .then(data => {
                const idx = lunr(function () {
                    this.field('title', { boost: 10 });
                    this.field('content');
                    this.field('category');
                    
                    data.docs.forEach((doc, index) => {
                        doc.id = index;
                        this.add(doc);
                    });
                });

                const results = idx.search(searchTerm);
                const resultStore = {};
                data.docs.forEach((doc, index) => {
                    resultStore[index] = doc;
                });
                
                displaySearchResults(results, resultStore);
            });
    }
})(); 