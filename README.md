# Hyrax: A Digital Repository Framework


This is the UB Libraries' development Hyrax instance. We're currently testing a Hyrax 5.0.4 (Sirenia) instance w/ Valkyrie, Fedora 6, and OCFL.

## UB-Specific Configs/Addons:
- Role management (via hydra-role-management) and very basic config
- OAI-PMH (via blacklight_oai_provider)
- Bulkrax (not working but sidebar additions are there)
- No headless Chromium container


## TODO 
- configure OAI for our specific use
- Bulkrax stuff - does it work in Fedora 6? 
  - browse-everything file selector (for cloud file upload) not working - button does nothing
- Get the non-Bulkrax batch importer tested (if it exists...?)
- Email setup (look at Hyku configs)
