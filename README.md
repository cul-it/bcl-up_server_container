# Blue Core Lookup (BCL-UP) Server Container and Application Orchestration
**BCL-UP Server Container** is forked from the work of [qa_server_container](https://github.com/LD4P/qa_server_container), and is tailored for the needs of the
[Blue Core](https://bluecore.info/) Project.

This app can be installed using Docker to serve as a Questioning Authority (QA) Server for accessing external authorities.
It is part of a larger architecture supporting linked data authority access.
See [LD4P/linked_data_authorities](https://github.com/LD4P/linked_data_authorities) for more information on the full architecture.
From this app, you can send a search query and get back multiple results OR you can fetch a single term. 

## Setup


[Setting up a development environment](https://github.com/LD4P/qa_server_container/wiki/Setting-up-a-development-environment)


### Setup on AWS

TBD

#### Installation Instructions


## Using the configuration

TEST QUERY: http://localhost:3000/qa/search/linked_data/_AUTHORITY_NAME__direct?q=your_query&maxRecords=3
TEST FETCH: http://localhost:3000/qa/show/linked_data/_AUTHORITY_NAME__direct/_ID_OR_URI_

Substitute the name of the configuration file for _AUTHORITY_NAME__direct in the URL.
Substitute a valid ID or URI for _ID_OR_URI_ in the URL, as appropriate.  NOTE: Some authorities expect an ID and others expect a URI.


### Expected Results

#### Search Query Results

This search query... http://localhost:3000/qa/search/linked_data/oclc_fast/personal_name?q=Cornell&maximumRecords=3
              
will return results like...
 
```
[{"uri":"http://id.worldcat.org/fast/5140","id":"5140","label":"Cornell, Joseph"},
 {"uri":"http://id.worldcat.org/fast/72456","id":"72456","label":"Cornell, Sarah Maria, 1802-1832"},
 {"uri":"http://id.worldcat.org/fast/409667","id":"409667","label":"Cornell, Ezra, 1807-1874"}]
```

#### Term Fetch Results

This term fetch... http://localhost:3000/qa/show/linked_data/oclc_fast/530369
                   
will return results like...

```
{"uri":"http://id.worldcat.org/fast/530369",
 "id":"530369","label":"Cornell University",
 "altlabel":["Ithaca (N.Y.). Cornell University","Kornelʹskii universitet","Kʻang-nai-erh ta hsüeh"],
 "sameas":["http://id.loc.gov/authorities/names/n79021621","https://viaf.org/viaf/126293486"],
 "predicates":{
   "http://purl.org/dc/terms/identifier":"530369",
   "http://www.w3.org/2004/02/skos/core#inScheme":["http://id.worldcat.org/fast/ontology/1.0/#fast","http://id.worldcat.org/fast/ontology/1.0/#facet-Corporate"],
   "http://www.w3.org/1999/02/22-rdf-syntax-ns#type":"http://schema.org/Organization",
   "http://www.w3.org/2004/02/skos/core#prefLabel":"Cornell University",
   "http://schema.org/name":["Cornell University","Ithaca (N.Y.). Cornell University","Kornelʹskii universitet","Kʻang-nai-erh ta hsüeh"],
   "http://www.w3.org/2004/02/skos/core#altLabel":["Ithaca (N.Y.). Cornell University","Kornelʹskii universitet","Kʻang-nai-erh ta hsüeh"],
   "http://schema.org/sameAs":["http://id.loc.gov/authorities/names/n79021621","https://viaf.org/viaf/126293486"]}}
```

## Connection and Accuracy Validations

Validations come in two flavors...
* connection validation - PASS if a request gets back a specified minimum size result set from an authority; otherwise, FAIL.  
* accuracy test - PASS if a specific result is returned by a specified position (e.g. uri is in the top 10 results); otherwise, FAIL.

The validations can be defined in a file with a matching file name in the [scenarios directory](https://github.com/ld4l-labs/qa_server/tree/master/config/authorities/linked_data/scenarios).  For example, direct access to the AgroVoc authority, access is configured in [config/authorities/linked_data/agrovoc_direct.json](https://github.com/ld4l-labs/qa_server/blob/master/config/authorities/linked_data/agrovoc_direct.json) and the validations are defined in [config/authorities/linked_data/scenarios/agrovoc_direct_validation.yml](https://github.com/ld4l-labs/qa_server/blob/master/config/authorities/linked_data/scenarios/agrovoc_direct_validation.yml)

The UI for bcl_up_server provides access to running connection validation and accuracy tests in the Check Status navigation menu item.

## Non linked-data authority access

QA Server is based on the [Questioning Authority gem](https://github.com/samvera/questioning_authority).  As such, it can be used to serve up controlled vocabularies defined in one of three ways.

1. locally defined controlled vocabularies
1. specifically supported external authorities (non-linked data)
1. configurable access to linked data authorities


## Running Tests in the Docker Container

The `run_tests.sh` script allows you to run tests for both:

1. The **Rails application** inside the Docker container.
2. The **bcl_up_server gem** inside the container.

This ensures that both the app and the gem are working as expected in the containerized environment.

**Note:** The script assumes that the Rails app is running in a container named `bcl-up_server_container`.

### 🚀 **Usage**

Run the script from the project root:

```sh
./run_tests.sh
```
This will:

* Detect the running Rails container.
* Run RSpec tests for bcl-up_server_container.
* Locate the bcl_up_server gem inside the container.
* Run the gem's test suite using bundle exec rake test_gem.

### 🚀 **Running a specific test file**
You can run a specific test file for the Rails app by passing the file path:

```sh
  ./run_tests.sh spec/path/to/test_file_spec.rb
```

This will:
* Run only the specified test file inside the container.
* Still execute the gem's test suite afterward.

### 🔴 **Handling Errors**
* If no running Rails container is found, the script will exit with an error.
* If the bcl_up_server gem is not found, the script will exit with an error.
* If the test_gem task is missing, the script will fail instead of falling back to other tasks.

This document addresses the use of BCL-UP Server app for access to linked data authorities.  You can reference Questioning Authorities
[documentation](https://github.com/samvera/questioning_authority/blob/master/README.md) for more information on the other uses.
