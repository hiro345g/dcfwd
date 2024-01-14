#!/bin/sh
npm exec -y --package=@angular/cli -- \
  ng new \
    --interactive false \
    --defaults true \
    --skip-git \
    --minimal true \
    app-sample-minimal
