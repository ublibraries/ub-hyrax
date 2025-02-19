#!/bin/bash
docker compose -f docker-compose-sirenia.yml up -d && docker compose -f docker-compose-sirenia.yml logs -f
