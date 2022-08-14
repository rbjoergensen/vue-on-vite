aws s3 cp --content-type image/svg+xml --acl public-read dist/ s3://cotv-vue-test/ --metadata-directive REPLACE --exclude "*" --include "*.svg" --recursive
aws s3 cp --content-type text/javascript --acl public-read dist/ s3://cotv-vue-test/ --metadata-directive REPLACE --exclude "*" --include "*.js" --recursive
aws s3 cp --content-type text/css --acl public-read dist/ s3://cotv-vue-test/ --metadata-directive REPLACE --exclude "*" --include "*.css" --recursive
aws s3 cp --content-type text/html --acl public-read dist/ s3://cotv-vue-test/ --metadata-directive REPLACE --exclude "*" --include "*.html" --recursive
aws cloudfront create-invalidation --distribution-id E200Z1Z9M3PO9G --paths "/*"