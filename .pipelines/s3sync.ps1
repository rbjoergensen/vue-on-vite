function Wait-CloudFrontStatus {
    param (
        [string]$DistributionId
    )

    $status = aws cloudfront get-distribution --id $DistributionId --query 'Distribution.Status' --output text
    "Distribution $status"

    while ($status -ne "Deployed") {
        Write-Host "Waiting for CloudFront distribution to be deployed, current state is $status"
        Start-Sleep -s 5
        $status = aws cloudfront get-distribution --id $DistributionId --query 'Distribution.Status' --output text
    }
}

function Wait-CloudFrontInvalidation {
    param (
        [string]$DistributionId,

        [string]$InvalidationId
    )

    $status = aws cloudfront get-invalidation --distribution-id $DistributionId --id $InvalidationId --query 'Invalidation.Status' --output text
    print "Invalidation $status"

    while ($status -ne "Completed") {
        Write-Host "Waiting for CloudFront invalidation to be finished, current state is $status"
        Start-Sleep -s 5
        $status = aws cloudfront get-invalidation --distribution-id "E200Z1Z9M3PO9G" --id $InvalidationId --query 'Invalidation.Status' --output text
    }
}

$DistributionId = "E200Z1Z9M3PO9G"

aws s3 sync dist/ s3://cotv-vue-test/ --acl public-read --delete
aws s3 cp --content-type image/svg+xml --acl public-read dist/ s3://cotv-vue-test/ --metadata-directive REPLACE --exclude "*" --include "*.svg" --recursive
aws s3 cp --content-type text/javascript --acl public-read dist/ s3://cotv-vue-test/ --metadata-directive REPLACE --exclude "*" --include "*.js" --recursive
aws s3 cp --content-type text/css --acl public-read dist/ s3://cotv-vue-test/ --metadata-directive REPLACE --exclude "*" --include "*.css" --recursive
aws s3 cp --content-type text/html --acl public-read dist/ s3://cotv-vue-test/ --metadata-directive REPLACE --exclude "*" --include "*.html" --recursive

Wait-CloudFrontStatus -DistributionId $DistributionId

$invalidation = aws cloudfront create-invalidation --distribution-id $DistributionId --paths "/*" --no-cli-pager --query 'Invalidation.Id' --output text

Wait-CloudFrontInvalidation -DistributionId $DistributionId -InvalidationId $invalidation

Wait-CloudFrontStatus -DistributionId $DistributionId
