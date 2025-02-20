#!/bin/bash
docker compose -f docker-compose-sirenia.yml exec -w /app/samvera/hyrax-webapp web bundle exec rails restart
