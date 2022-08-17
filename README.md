# README

Playground project to learn about:

- Using Rails with Docker
- Rails 7, specially hotwire

# Deploy

Switch to `production` branch

Run:

```bash
gcloud builds submit --config cloudbuild.yaml

gcloud run deploy backend-web --platform managed --region us-central1 --image gcr.io/wuufcl/backend-web --add-cloudsql-instances wuufcl:us-central1:wuuf-postgres --allow-unauthenticate
```
