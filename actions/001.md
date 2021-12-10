<!-- wp:paragraph -->
<p>In this walkthrough, we will do Azure CLI Login using GitHub Actions</p>
<!-- /wp:paragraph -->

<!-- wp:list -->
<ul><li>Create AD App <ul><li>Login to Azure subscription. Create a service principal with a secret.</li><li>Copy the json output of the command for creating the secret</li></ul></li></ul>
<!-- /wp:list -->

<!-- wp:syntaxhighlighter/code {"language":"bash"} -->
<pre class="wp-block-syntaxhighlighter-code">az ad sp create-for-rbac --name "githubActions" --role contributor --scopes /subscriptions/&lt;subscripionId>/resourceGroups/&lt;rgName> --sdk-auth</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:image {"id":3419,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://zaidcloud.files.wordpress.com/2021/12/adapp.png?w=1024" alt="" class="wp-image-3419"/><figcaption>AD App </figcaption></figure>
<!-- /wp:image -->

<!-- wp:list -->
<ul><li>Create GitHub Secret<ul><li>Login to GitHub, and browse to the setting for your repo.</li></ul><ul><li>Go to Secrets, click New repository secret</li><li>Create secret name AZURE_CREDENTIALS</li><li>Paste the value you copied when creating AD App</li></ul></li></ul>
<!-- /wp:list -->

<!-- wp:image {"id":3421,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://zaidcloud.files.wordpress.com/2021/12/secrets.png?w=1024" alt="" class="wp-image-3421"/><figcaption>Add Secrets</figcaption></figure>
<!-- /wp:image -->

<!-- wp:list -->
<ul><li>Create Workflow<ul><li>Browse to Actions.</li><li>You can select sample workflow templates or click on "set up a workflow yourself"</li></ul></li></ul>
<!-- /wp:list -->

<!-- wp:image {"id":3423,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://zaidcloud.files.wordpress.com/2021/12/gh1.png?w=1024" alt="" class="wp-image-3423"/><figcaption>Workflow template</figcaption></figure>
<!-- /wp:image -->

<!-- wp:list -->
<ul><li>Copy the code to the workflow</li></ul>
<!-- /wp:list -->

<!-- wp:syntaxhighlighter/code {"language":"yaml"} -->
<pre class="wp-block-syntaxhighlighter-code"># This is a basic workflow to help you get started with Actions

on: [push]

name: AzureDemo

jobs:

  build-and-deploy:
    runs-on: ubuntu-latest
    steps:
    
    - uses: azure/login@v1
      with:
        creds: ${{ secrets.AZURE_CREDENTIALS }}
    
    - run: |
        az account show</pre>
<!-- /wp:syntaxhighlighter/code -->

<!-- wp:image {"id":3425,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://zaidcloud.files.wordpress.com/2021/12/gh2.png?w=1024" alt="" class="wp-image-3425"/></figure>
<!-- /wp:image -->

<!-- wp:list -->
<ul><li>Commit the change to repo</li></ul>
<!-- /wp:list -->

<!-- wp:image {"id":3426,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://zaidcloud.files.wordpress.com/2021/12/gh3.png?w=874" alt="" class="wp-image-3426"/></figure>
<!-- /wp:image -->

<!-- wp:list -->
<ul><li>Go to Actions </li></ul>
<!-- /wp:list -->

<!-- wp:image {"id":3427,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://zaidcloud.files.wordpress.com/2021/12/gh4.png?w=1024" alt="" class="wp-image-3427"/></figure>
<!-- /wp:image -->

<!-- wp:list -->
<ul><li>Click on the running job to see the status/output</li></ul>
<!-- /wp:list -->

<!-- wp:image {"id":3430,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://zaidcloud.files.wordpress.com/2021/12/gh5-1.png?w=1024" alt="" class="wp-image-3430"/></figure>
<!-- /wp:image -->
