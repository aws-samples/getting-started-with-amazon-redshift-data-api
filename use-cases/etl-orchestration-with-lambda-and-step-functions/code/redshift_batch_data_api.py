<!DOCTYPE html>
<html>
<head>
<title>redshift_batch_data_api.py - Amazon-redshift-data-api-getting-started - Code Browser</title>
<meta content='width=device-width, initial-scale=1' name='viewport'>
<meta content='true' name='use-sentry'>
<meta content='8d1d977e-bcbb-477d-8ddf-83e2baad7e37' name='request-id'>
<meta name="csrf-param" content="authenticity_token" />
<meta name="csrf-token" content="9xxI2oqnNPh05L+MDMC8bhHXstgrc38xdxRsi6V6iSHL9BYry5C5R+Lb1Bz9OkhIYPU8W7NLHr2L3s5ZRlu/qA==" />
<meta content='IE=edge' http-equiv='X-UA-Compatible'>

<link rel="shortcut icon" type="image/x-icon" href="https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/favicon-c8c77da180d3e9e679dac48d5ae77858edd6974d6a2a78b1705dc0b499c1d7c2.ico" />
<link rel="stylesheet" media="all" href="https://m.media-amazon.com/images/G/01/oneg/assets/3.2.4/css/application.min.css" />
<link rel="stylesheet" media="all" href="https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/vendor-90acffb4f83d4fac4e18700dd74243643e9d8b5e81b5c61e7e52383ae980ab29.css" />
<link rel="stylesheet" media="all" href="https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/application-oneg-b0d2918a35db96d2b15378ac99385b5e1e01275304cdd53ccab39522e1054546.css" />
<link rel="stylesheet" media="all" href="https://internal-cdn.amazon.com/is-it-down.amazon.com/stylesheets/stripe.css" />
<style>
  .absolute-time {
    display: none; }
  
  .relative-time {
    display: auto; }
</style>
<style>
  .add_related_items {
    display: none; }
  
  #related_items {
    margin-top: 10px;
    text-align: right;
    min-height: 50px; }
    #related_items .error {
      color: red; }
</style>
<link rel="stylesheet" media="screen" href="https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/spiffy_diffy_assets/spiffy_diffy-ae36511172a0f079b00af773e85db1f4d5487f8f415e97b89baaae2c05113dd3.css" />
<link rel="stylesheet" media="screen" href="https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/blobs-b13b6a7caacd4135de19896de8b46573cb30e250f79cfa77c7916f397be6f24f.css" />

</head>
<body>
<nav class='navbar navbar-default hidden-print' role='navigation'>
<div class='container-fluid'>
<div class='navbar-header'>
<a class='navbar-brand' href='/' title='Code Browser Website'>
Code Browser
</a>
</div>
<ul class='nav navbar-nav'>
<li>
<div class='advanced-search-hover-link'>
<!-- / preserves query and redirects to advanced search -->
<a class="fa fa-magic" href="/search?&amp;commit=Search"></a>
</div>
<form action='/search' class='form-inline navbar-search navbar-form'>
<div class='search-spinner' style='display:none'>
<img src='https://images-na.ssl-images-amazon.com/images/G/01/oneg/img/spinner.gif'>
</div>
<div class='input-append inline-elem'>
<input accesskey='s' class='hinted input-medium autocomplete-packages search-query form-control search' data-autocomplete-url='/packages/autocomplete_package_id?vs=true' id='search_top' name='term' placeholder='Code Search' role='search' size='40' tabindex='1' title='Code Search' type='text'>
</div>
<a href='#'>
<img target_popup="search-bar-hint" src="https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/tooltip-bubble-c216fb54e673c87bc8058ff6778cbe0b94538db89ab1b9cf59935c5dadc7f96e.png" />
</a>
<div class='popover fade right in code-search-help-box nav' id='search-bar-hint'>
<h3 class='popover-title'>Code Search Hints</h3>
<div class='popover-content'>
<p>
<strong class='external text'>
<a href='/search' rel='nofollow'>Advanced Search</a>
</strong>
</p>
<p>
<strong>Simple search:</strong>
&lt;term&gt;
</p>
<p>
<strong>Prefix search:</strong>
&lt;at-least-three-chars&gt;*
</p>
<p>
<strong>Find files with at least one of two terms (logical OR):</strong>
&lt;term1&gt; &lt;term2&gt;
</p>
<p>
<strong>Find files with at least one of two terms but not a third term:</strong>
&lt;term1&gt; &lt;term2&gt;&nbsp;!&lt;term3&gt;
</p>
<p>
<strong>Find files with two terms in sequence:</strong>
"&lt;term1&gt; &lt;term2&gt;"
</p>
<p>
<strong>Filter to only one or more repository:</strong>
&lt;term1&gt; rp:&lt;MyPackageName&gt; ...
</p>
<p>
<strong>Filter to a particular file extension:</strong>
&lt;term1&gt; path:.java
</p>
<p>
<strong>Filter out a particular file extension (works w/ all filters):</strong>
&lt;term1&gt; path:!.java
</p>
<p>
<strong>Find files with two terms with filters (logical AND):</strong>
&lt;term1&gt; &lt;term2&gt; path:.md ...
</p>
<p>
<strong>Filter to a path: &lt;term1&gt;</strong>
path:/my/path/to/consider*
</p>
<p>
<strong>Filter by write permissions:</strong>
group:&lt;some-ldap-posix-or-source-group&gt;
</p>
<p>
<strong>Filter by package status:</strong>
status:active:deprecated
</p>
<p>
<strong>Filter by branch: branch:&lt;branch-name&gt;</strong>
</p>
<p>
<strong>Filter by third party:</strong>
third_party:true|false
</p>
<p>
<strong>Filter by particular class in java files:</strong>
class:&lt;class_name&gt;
</p>
<p>
<strong>Filter by method declarations in java files:</strong>
method:&lt;method_name&gt;
</p>
<p>
<strong>Filter by method calls in java files:</strong>
method_call:&lt;method_name&gt;
</p>
<p>
<strong>Filter by interface declarations in java files:</strong>
interface:&lt;interface_name&gt;
</p>
<p>
<a class='external text' href='https://builderhub.corp.amazon.com/docs/code-browser/user-guide/code-search.html' rel='nofollow'>Read more here</a>
</p>
<p>
<i>(click on the speech bubble to close)</i>
</p>
</div>
</div>

</form>
</li>
<li>
<a href="/permissions">Permissions</a>
</li>
<li>
<a href="/workspaces/pedrezaj">Workspaces</a>
</li>
<li>
<a href="/version-sets">Version Sets</a>
</li>
<li>
<a href="/reviews">Code Reviews</a>
</li>
<li>
<a data-target='#preferences_dialog' data-toggle='modal' id='preferences'>Preferences</a>
<div class='modal fade' id='preferences_dialog' role='dialog'>
<div class='modal-dialog modal-md'>
<div class='modal-content'>
<div class='modal-header'>
<button class='close' data-dismiss='modal' type='button'>
<i class='fa fa-times'></i>
</button>
<h4 class='modal-title'>User Preferences</h4>
</div>
<div class='modal-body'>
<div class='text-center'>
<i class='fa fa-spinner fa-spin'></i>
</div>
</div>
</div>
</div>
</div>
</li>
</ul>
<div class='nav navbar-nav navbar-right parent-tag-container'>
<div class='tag-container'>
<a class='tag-link' href='https://w.amazon.com/bin/view/BuilderTools/Groups/Codex/Hiring/' target='_blank'>We are hiring!</a>
</div>
</div>
<ul class='nav navbar-nav navbar-right parent-button-container'>
<li>
<button class='btn nav-button' id='tiny-link'>Tiny Link</button>
</li>
</ul>
</div>
</nav>

<div class='container-fluid'>
<ol class='breadcrumb'>
<li>
<a href="/">Home</a>
</li>
<li><a href="/packages/Amazon-redshift-data-api-getting-started">Amazon-redshift-data-api-getting-started</a></li>
<li><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/">mainline</a></li>
<li><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/use-cases">use-cases</a></li>
<li><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions">etl-orchestration-with-lambda-and-step-functions</a></li>
<li><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/code">code</a></li>
<li class='.active'>redshift_batch_data_api.py</li>


</ol>
<div id='content'>
</div>

<div class='page-header'>
<h1>
<span>
Amazon-redshift-data-api-getting-started
</span>
<div class='star' data-package='Amazon-redshift-data-api-getting-started'></div>
<small class='hidden-print'>
<a class='powertip autoselect pull-right' data-powertip='brazil ws use -p Amazon-redshift-data-api-getting-started' id='bw_use'>
<i class='glyphicon glyphicon-download-alt'></i>
</a>
</small>
<small>
<span class='clone subtext pull-right hidden-print'>
<form class='form-inline'>
Clone uri:
<input class='form-control input-sm' type='text' value='ssh://git.amazon.com/pkg/Amazon-redshift-data-api-getting-started'>
</form>
</span>

</small>
<small>
<div class='pull-right hidden-print' id='code_search_box'>
<form class="form-inline" action="/search_redirector" accept-charset="UTF-8" method="get"><input name="utf8" type="hidden" value="&#x2713;" />
<div class='input-group search '><input type="text" name="search_term" id="search_term" placeholder="Search in this package" size="21" class="form-control input-sm" />
<span class='input-group-btn'><button class='btn' type='submit'>Go</button></span></div><input type="hidden" name="package" id="package" value="Amazon-redshift-data-api-getting-started" />
<input type="hidden" name="path" id="path" value="use-cases/etl-orchestration-with-lambda-and-step-functions/code/redshift_batch_data_api.py" />
</form>

</div>

</small>
</h1>
<div class='badges'>
<div class='placeholder'>
&nbsp
</div>
<span id='third_party' style='display: none;'>
<span class='label label-info'>Third Party Package</span>
</span>
<div class='popover fade right in badge-helper-box' id='badge-hints'>
<h3 class='popover-title'>Hint</h3>
<div class='badge-helper-content popover-content'>
<p>
Package badge data is extracted from brazil metadata about a package.  Particularly, Code Browser finds the highest major version and fetches data about that package version from the latest build in the primary version set.
</p>
<p>
The metadata we have is based on following brazil conventions about where to place documentation and unit test (and coverage) output.  Here are a few other wiki pages that have more detailed information about these topics.
</p>
<ul>
<li>
Each
<a class='external text' href='https://w.amazon.com/index.php/BrazilBuildSystem/BuildSystems' rel='nofollow'>build system</a>
may have ways to configure build artifacts that the Brazil system recognizes.
</li>
<li>
Java - if you use
<a class='external text' href='https://w.amazon.com/index.php/BrazilBuildSystem/HappierTrails' rel='nofollow'>Happier Trails</a>
you should get test, documentation, and coverage data out of the box.
</li>
<li>
This
<a class='external text' href='https://w.amazon.com/index.php/BrazilBuildSystem/Concepts/UnitTestingInBrazil/JavaUnitTesting' rel='nofollow'>Java Unit Testing</a>
page describes the basic conventions underlying test output.  Most any language / build system can output usable information just by putting the right files in the right places.
</li>
</ul>
<p>
Here are some example packages for a few languages that are configured to expose this information to Brazil:
</p>
<ul>
<li>
Java -
<a class='external text' href='https://code.amazon.com/packages/ToolsPermsService/blobs/mainline/--/build.xml' rel='nofollow'>ToolsPermsService</a>
</li>
<li>
Ruby -
<a class='external text' href='https://code.amazon.com/packages/CriticService/blobs/mainline/--/Rakefile' rel='nofollow'>CriticService</a>
(
<a class='external text' href='https://w.amazon.com/index.php/BuilderTools/Product/BrazilRake' rel='nofollow'>BrazilRake's</a>
SimpleCov does most of the work)
</li>
<li>
Python -
<a class='external text' href='https://code.amazon.com/packages/Ducky/blobs/62906a55e2c53e9dc779a00770b39b0620d74c45/--/Config#line-48' rel='nofollow'>Ducky</a>
</li>
<li>
Perl - ?
</li>
</ul>
</div>
</div>

</div>
</div>
<div class='row'>
<div class='col-md-9'>
<ul class='nav nav-pills bottom-buffer-small hidden-print'>
<li class='active'><a href="/packages/Amazon-redshift-data-api-getting-started">Source</a></li>
<li><a href="/packages/Amazon-redshift-data-api-getting-started/logs">Commits</a></li>
<li><a href="/packages/Amazon-redshift-data-api-getting-started/releases">Releases</a></li>
<li><a href="/packages/Amazon-redshift-data-api-getting-started/metrics/28a67ed63469e767ff917f71d9697275aa578490">Metrics</a></li>
<li><a href="/packages/Amazon-redshift-data-api-getting-started/permissions">Permissions</a></li>
<li><a href="/gc/rules/for-package/Amazon-redshift-data-api-getting-started">CRUX Rules</a></li>
<li><a href="/packages/Amazon-redshift-data-api-getting-started/repo-info">Repository Info</a></li>
<li><a href="/packages/Amazon-redshift-data-api-getting-started/replicas">CodeCommit Replicas</a></li>
</ul>

</div>
<div class='col-md-3'>
<div id='branch_and_search_box'>
<div class='hidden-print' id='branch_dropdown'>
<label for="branches">Branches: </label>
<input id='branches' name='branches' type='hidden'>
</div>

</div>

</div>
</div>
<div class='last_commit panel panel-default top-buffer-small'>
<div class='last_commit_heading'>
Last Commit
<span class='subtext'>
(<a class="commit-see-more" href="#">see more</a>)
</span>
</div>
<div class='panel-body'>
<ul class='last-commit-summary list-unstyled list-inline'>
<li class='commiter'></li>
<a title="rzhamzn-at-601176997573" href="https://code.amazon.com/users/rzhamzn/activity">rzhamzn-at-601176997573</a>
<li class='time'></li>
<span title='Committed on January 11, 2022 11:11:29 PM PST' class='relative-time hover_tooltip year_old'>about 2 months ago</span><span class='absolute-time hover_tooltip year_old'>2022-01-11 23:11:29 PST</span>
<li class='commit_message'>
<span class='refs'>
</span>
<a class='powertip commit black' data-commit-id='28a67ed63469e767ff917f71d9697275aa578490' href='/packages/Amazon-redshift-data-api-getting-started/commits/28a67ed63469e767ff917f71d9697275aa578490'>
sync
</a>
</li>
<li><a class="mono powertip autoselect" data-powertip="28a67ed63469e767ff917f71d9697275aa578490" data-commit-id="28a67ed63469e767ff917f71d9697275aa578490" href="/packages/Amazon-redshift-data-api-getting-started/commits/28a67ed63469e767ff917f71d9697275aa578490#use-cases/etl-orchestration-with-lambda-and-step-functions/code/redshift_batch_data_api.py">28a67ed6</a></li>
<li>
<img alt="Pipelines logo" src="https://internal-cdn.amazon.com/pipelines.amazon.com/public/assets/favicon-a58010788e2014b36083d9b8766021876b1f1e219ed5496b9cc040a2712e4ea1.ico" />
<a href="https://pipelines.amazon.com/changes/PKG/Amazon-redshift-data-api-getting-started/mainline/GitFarm:28a67ed63469e767ff917f71d9697275aa578490">Track in pipelines</a>
</li>
</ul>

<div class='swappable-with-brief-header'>
<div class='commit_header'>
<div class='portrait'>
<div style='display: flex'>
<div style='margin-left: 5px'>
<a href="https://code.amazon.com/users/rzhamzn/activity"><img class="" width="50" onerror="this.onerror=null; this.src=&#39;https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/default-user-b916c01d82910755cdba17db81688d35c994cf77a5907d721a6d93522961d007.gif&#39;" src="https://internal-cdn.amazon.com/badgephotos.amazon.com/phone-image.pl?uid=rzhamzn" /></a>
</div>
</div>
</div>
<div class='details'>
<div class='pull-right' id='track_pipeline_change' style='clear-right'>
<ul class='list-unstyled'>
<li>
<img src="https://pipelines.amazon.com/favicon.ico" />
<a href="https://pipelines.amazon.com/changes/PKG/Amazon-redshift-data-api-getting-started/mainline/GitFarm:28a67ed63469e767ff917f71d9697275aa578490">Track in pipelines</a>
<span class='subtext'>(mainline)</span>
</li>
</ul>
</div>
<div class='download-diff pull-right' style='clear: right'>
<a href="/api/packages/Amazon-redshift-data-api-getting-started/diff/28a67ed63469e767ff917f71d9697275aa578490">Download Diff</a>
</div>
<div class='pull-right' id='browse_source' style='clear: right'>
<a href="/packages/Amazon-redshift-data-api-getting-started/trees/28a67ed63469e767ff917f71d9697275aa578490">Browse source at this commit</a>
</div>
<div class='pull-right' id='child_link' style='clear: right'>
<a href="/packages/Amazon-redshift-data-api-getting-started/commits/28a67ed63469e767ff917f71d9697275aa578490.child">view child commit</a>
</div>
<ul class='list-unstyled pull-right' style='clear: right; margin-bottom: 0px'>
<li><a href="/packages/Amazon-redshift-data-api-getting-started/commits/cc439589df2c0d50b6965e6e41f6da2e80a64931">view parent (cc439589)</a></li></ul>
<div class='pull-right' id='related_items' style='clear: right'>
<h4>
Related Items
<small class='add_relation_link'>
<a href='#'>+Add</a>
</small>
</h4>
<div class='fetching subtext'>
Fetching...
</div>
<div class='msg subtext' style='display: none'>
(none)
</div>
<ul class='list-unstyled' data-bind='foreach: relatedItemsModel().relatedItems, visible: relatedItemsModel().relatedItems().length &gt; 0'>
<li>
<span data-bind='text: type'></span>
<a data-bind='text: link.title, attr: {href: link.url}'></a>
<a class='delete_relation' data-bind='attr: {href: &#39;/delete-relation?eid=&#39; + link.eid}' onclick='return confirm(&quot;Really delete this relation?&quot;)'>
<span class='red'>&nbsp;x&nbsp;</span>
</a>
</li>
</ul>
<div class='add_related_items'>
<form action="/create_relation" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><input type="hidden" name="authenticity_token" value="9tTGuMRbcVgEmqRSD7rVc5fOSAREai+/+v5fM+82oWLKPJhJhWz855Klz8L+QCFV5uzGh9xSTjMGNP3hDBeX6w==" />
Relate this commit to url:
<input name='relation' type='text'>
<input type="hidden" name="package_id" id="package_id" value="Amazon-redshift-data-api-getting-started" />
<input type="hidden" name="commit_id" id="commit_id" value="28a67ed63469e767ff917f71d9697275aa578490" />
<input type="submit" name="commit" value="Save" class="btn btn-default" data-disable-with="Save" />
</form>

</div>
</div>
<div class='author'>
<div class='author-line' style='font-size: 120%'>
<span class='name'><a title="rzhamzn-at-601176997573" href="https://code.amazon.com/users/rzhamzn/activity">rzhamzn-at-601176997573</a></span>
<span class='sha1'>
(<a class='powertip autoselect' data-powertip='28a67ed63469e767ff917f71d9697275aa578490' href='/packages/Amazon-redshift-data-api-getting-started/commits/28a67ed63469e767ff917f71d9697275aa578490'>28a67ed6</a>)
</span>
</div>
<div id='extra-commit-and-branch-info'>
authored: <span title='January 11, 2022 11:11:29 PM PST' class='relative-time hover_tooltip year_old'>about 2 months ago</span><span class='absolute-time hover_tooltip year_old'>2022-01-11 23:11:29 PST</span>, committed: <span title='January 11, 2022 11:11:29 PM PST' class='relative-time hover_tooltip year_old'>about 2 months ago</span><span class='absolute-time hover_tooltip year_old'>2022-01-11 23:11:29 PST</span>
<div class='summaries'>
<div class='summary'>
Pushed to
<span class='autoselect branch powertip ref' data-powertip='mainline'>mainline</span>
by rzhamzn <span title='January 11, 2022 11:12:02 PM PST' class='relative-time hover_tooltip year_old'>about 2 months ago</span><span class='absolute-time hover_tooltip year_old'>2022-01-11 23:12:02 PST</span> as part of <a class='powertip autoselect' data-powertip='76c18ab13cdcb7f10c5c77d184b8cab6e0246f91' href='/packages/Amazon-redshift-data-api-getting-started/commits/76c18ab13cdcb7f10c5c77d184b8cab6e0246f91'>76c18ab1</a>
</div>
</div>


</div>
<p class='top-buffer'>
<span class='subject'>
<a href="/packages/Amazon-redshift-data-api-getting-started/commits/28a67ed63469e767ff917f71d9697275aa578490">sync</a>
</span>
</p>
</div>
</div>
</div>

</div>
</div>
</div>
<div class='clear'></div>

<div class='jump_to_file hidden-print'>
<div class='jump_to_file_form'>
<form class='form_inline' onSubmit='return false'>
<input type="hidden" name="package_id" id="package_id" value="Amazon-redshift-data-api-getting-started" />
<input type="hidden" name="commit_id_for_file" id="commit_id_for_file" value="mainline" />
<div class='input-append'>
<input accesskey='j' class='hinted form-control search' id='filesearch' name='file' placeholder='Jump to a file' title='Jump to a file' type='text'>
</div>
<div class='jump_to_file_dismiss'></div>
</form>
</div>
<div class='jump_to_file_popup'><a class='help helpPopup' data-content='Here you can enter the name of the file and it will provide suggestions with the matching file names and the path for the same.&lt;br/&gt; After selecting the required file, it will redirect to that file. The keyboard shortcut is &#39;CTRL+j&#39;.'>
<img src="https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/tooltip-bubble-c216fb54e673c87bc8058ff6778cbe0b94538db89ab1b9cf59935c5dadc7f96e.png" />
</a>
</div>
<div class='jump_to_file_error'>
The above file can not be found. Either the whole path is missing or the file is not in
<br>this package. Please check the autosuggestions.</br>
</div>
</div>

<!--
mime_type: text/x-python; charset=us-ascii
-->
<div class='file_header'>
<div class='path_breadcrumbs'>
<div class='path_breadcrumbs'>
<span class='path_breadcrumb'><a href="/packages/Amazon-redshift-data-api-getting-started">Amazon-redshift-data-api-getting-started</a></span>/<span class='path_breadcrumb'><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/">mainline</a></span>/<span class='path_breadcrumb'><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/use-cases">use-cases</a></span>/<span class='path_breadcrumb'><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions">etl-orchestration-with-lambda-and-step-functions</a></span>/<span class='path_breadcrumb'><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/code">code</a></span>/<span class='path_breadcrumb'>redshift_batch_data_api.py</span>
</div>

</div>
<div class='hidden-print' id='file_actions'>
<ul class='button_group'>
<li>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/blobs/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/code/redshift_batch_data_api.py?raw=1">Raw</a>
</li>
<li>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/blobs/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/code/redshift_batch_data_api.py?download=1">Download</a>
</li>
<li>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/logs/mainline?path=use-cases%2Fetl-orchestration-with-lambda-and-step-functions%2Fcode%2Fredshift_batch_data_api.py">History</a>
</li>
<li>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/blobs/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/code/redshift_batch_data_api.py/edit_file_online">Edit</a>
</li>
<li class='permalink'>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/blobs/28a67ed63469e767ff917f71d9697275aa578490/--/use-cases/etl-orchestration-with-lambda-and-step-functions/code/redshift_batch_data_api.py">Permalink</a>
</li>
</ul>
<span class='blame subtext'>
<label>
show blame:
<input disabled type='checkbox'>
</label>
<span class='subtext'>Older</span>
<span class='age0 ageKey'>&nbsp;</span>
<span class='age20 ageKey'>&nbsp;</span>
<span class='age40 ageKey'>&nbsp;</span>
<span class='age60 ageKey'>&nbsp;</span>
<span class='age80 ageKey'>&nbsp;</span>
<span class='age100 ageKey'>&nbsp;</span>
<span class='subtext'>Newer</span>
</span>
</div>
<div class='clear'></div>
<div class='highlighttable blob' ng_non_bindable>
  
    <div class="js-syntax-highlight-wrapper">
      <table class="code js-syntax-highlight">
        <tbody>
          
            
            <tr class="line_holder" id="L1">
              <td class="line-num" data-linenumber="1">
                <span class="linked-line" unselectable="on" data-linenumber="1"></span>
              </td>
              
              <td class="line_content"><span class="kn">import</span> <span class="nn">os</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L2">
              <td class="line-num" data-linenumber="2">
                <span class="linked-line" unselectable="on" data-linenumber="2"></span>
              </td>
              
              <td class="line_content"><span class="kn">import</span> <span class="nn">sys</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L3">
              <td class="line-num" data-linenumber="3">
                <span class="linked-line" unselectable="on" data-linenumber="3"></span>
              </td>
              
              <td class="line_content"><span class="kn">import</span> <span class="nn">json</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L4">
              <td class="line-num" data-linenumber="4">
                <span class="linked-line" unselectable="on" data-linenumber="4"></span>
              </td>
              
              <td class="line_content"><span class="kn">from</span> <span class="nn">pathlib</span> <span class="kn">import</span> <span class="n">Path</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L5">
              <td class="line-num" data-linenumber="5">
                <span class="linked-line" unselectable="on" data-linenumber="5"></span>
              </td>
              
              <td class="line_content"><span class="kn">from</span> <span class="nn">pip._internal</span> <span class="kn">import</span> <span class="n">main</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L6">
              <td class="line-num" data-linenumber="6">
                <span class="linked-line" unselectable="on" data-linenumber="6"></span>
              </td>
              
              <td class="line_content"><span class="c1"># install latest version of boto3</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L7">
              <td class="line-num" data-linenumber="7">
                <span class="linked-line" unselectable="on" data-linenumber="7"></span>
              </td>
              
              <td class="line_content"><span class="n">main</span><span class="p">([</span><span class="s">'install'</span><span class="p">,</span> <span class="s">'-I'</span><span class="p">,</span> <span class="s">'-q'</span><span class="p">,</span> <span class="s">'boto3'</span><span class="p">,</span> <span class="s">'--target'</span><span class="p">,</span> <span class="s">'/tmp/'</span><span class="p">,</span><span class="s">'--no-cache-dir'</span><span class="p">,</span> <span class="s">'--disable-pip-version-check'</span><span class="p">])</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L8">
              <td class="line-num" data-linenumber="8">
                <span class="linked-line" unselectable="on" data-linenumber="8"></span>
              </td>
              
              <td class="line_content"><span class="n">sys</span><span class="p">.</span><span class="n">path</span><span class="p">.</span><span class="n">insert</span><span class="p">(</span><span class="mi">0</span><span class="p">,</span> <span class="s">'/tmp/'</span><span class="p">)</span>   
</td>
            </tr>
          
            
            <tr class="line_holder" id="L9">
              <td class="line-num" data-linenumber="9">
                <span class="linked-line" unselectable="on" data-linenumber="9"></span>
              </td>
              
              <td class="line_content"><span class="kn">import</span> <span class="nn">boto3</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L10">
              <td class="line-num" data-linenumber="10">
                <span class="linked-line" unselectable="on" data-linenumber="10"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L11">
              <td class="line-num" data-linenumber="11">
                <span class="linked-line" unselectable="on" data-linenumber="11"></span>
              </td>
              
              <td class="line_content"><span class="n">redshift_client</span> <span class="o">=</span> <span class="n">boto3</span><span class="p">.</span><span class="n">client</span><span class="p">(</span><span class="s">'redshift-data'</span><span class="p">)</span> 
</td>
            </tr>
          
            
            <tr class="line_holder" id="L12">
              <td class="line-num" data-linenumber="12">
                <span class="linked-line" unselectable="on" data-linenumber="12"></span>
              </td>
              
              <td class="line_content"><span class="n">s3_client</span>  <span class="o">=</span> <span class="n">boto3</span><span class="p">.</span><span class="n">client</span><span class="p">(</span><span class="s">'s3'</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L13">
              <td class="line-num" data-linenumber="13">
                <span class="linked-line" unselectable="on" data-linenumber="13"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L14">
              <td class="line-num" data-linenumber="14">
                <span class="linked-line" unselectable="on" data-linenumber="14"></span>
              </td>
              
              <td class="line_content"><span class="k">def</span> <span class="nf">get_sql_script_from_s3</span><span class="p">(</span><span class="n">script_s3_path</span><span class="p">):</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L15">
              <td class="line-num" data-linenumber="15">
                <span class="linked-line" unselectable="on" data-linenumber="15"></span>
              </td>
              
              <td class="line_content">    <span class="n">bucket</span><span class="p">,</span> <span class="n">key</span> <span class="o">=</span> <span class="n">script_s3_path</span><span class="p">.</span><span class="n">replace</span><span class="p">(</span><span class="s">"s3://"</span><span class="p">,</span> <span class="s">""</span><span class="p">).</span><span class="n">split</span><span class="p">(</span><span class="s">"/"</span><span class="p">,</span> <span class="mi">1</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L16">
              <td class="line-num" data-linenumber="16">
                <span class="linked-line" unselectable="on" data-linenumber="16"></span>
              </td>
              
              <td class="line_content">    <span class="n">obj</span> <span class="o">=</span> <span class="n">s3_client</span><span class="p">.</span><span class="n">get_object</span><span class="p">(</span><span class="n">Bucket</span><span class="o">=</span><span class="n">bucket</span><span class="p">,</span> <span class="n">Key</span><span class="o">=</span><span class="n">key</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L17">
              <td class="line-num" data-linenumber="17">
                <span class="linked-line" unselectable="on" data-linenumber="17"></span>
              </td>
              
              <td class="line_content">    <span class="k">return</span> <span class="n">obj</span><span class="p">[</span><span class="s">'Body'</span><span class="p">].</span><span class="n">read</span><span class="p">().</span><span class="n">decode</span><span class="p">(</span><span class="s">'utf-8'</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L18">
              <td class="line-num" data-linenumber="18">
                <span class="linked-line" unselectable="on" data-linenumber="18"></span>
              </td>
              
              <td class="line_content">    
</td>
            </tr>
          
            
            <tr class="line_holder" id="L19">
              <td class="line-num" data-linenumber="19">
                <span class="linked-line" unselectable="on" data-linenumber="19"></span>
              </td>
              
              <td class="line_content"><span class="k">def</span> <span class="nf">split_sql_statement</span><span class="p">(</span><span class="n">script_s3_path</span><span class="p">,</span> <span class="n">job_run_date</span><span class="p">):</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L20">
              <td class="line-num" data-linenumber="20">
                <span class="linked-line" unselectable="on" data-linenumber="20"></span>
              </td>
              
              <td class="line_content">    <span class="n">script</span> <span class="o">=</span> <span class="n">get_sql_script_from_s3</span><span class="p">(</span><span class="n">script_s3_path</span><span class="p">).</span><span class="nb">format</span><span class="p">(</span><span class="n">job_run_date</span><span class="o">=</span><span class="n">job_run_date</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L21">
              <td class="line-num" data-linenumber="21">
                <span class="linked-line" unselectable="on" data-linenumber="21"></span>
              </td>
              
              <td class="line_content">    
</td>
            </tr>
          
            
            <tr class="line_holder" id="L22">
              <td class="line-num" data-linenumber="22">
                <span class="linked-line" unselectable="on" data-linenumber="22"></span>
              </td>
              
              <td class="line_content">    <span class="n">sql_statements</span> <span class="o">=</span> <span class="nb">list</span><span class="p">(</span><span class="nb">filter</span><span class="p">(</span><span class="bp">None</span><span class="p">,</span> <span class="n">script</span><span class="p">.</span><span class="n">split</span><span class="p">(</span><span class="s">';'</span><span class="p">)))</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L23">
              <td class="line-num" data-linenumber="23">
                <span class="linked-line" unselectable="on" data-linenumber="23"></span>
              </td>
              
              <td class="line_content">    <span class="k">return</span> <span class="n">sql_statements</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L24">
              <td class="line-num" data-linenumber="24">
                <span class="linked-line" unselectable="on" data-linenumber="24"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L25">
              <td class="line-num" data-linenumber="25">
                <span class="linked-line" unselectable="on" data-linenumber="25"></span>
              </td>
              
              <td class="line_content"><span class="k">def</span> <span class="nf">run_batch_sql</span><span class="p">(</span><span class="n">redshift_config</span><span class="p">,</span> <span class="n">sql_statements</span><span class="p">,</span> <span class="n">statement_name</span><span class="p">):</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L26">
              <td class="line-num" data-linenumber="26">
                <span class="linked-line" unselectable="on" data-linenumber="26"></span>
              </td>
              
              <td class="line_content">    <span class="c1"># execute the input SQL statement in the specified Amazon Redshift cluster</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L27">
              <td class="line-num" data-linenumber="27">
                <span class="linked-line" unselectable="on" data-linenumber="27"></span>
              </td>
              
              <td class="line_content">    <span class="n">api_response</span> <span class="o">=</span> <span class="n">redshift_client</span><span class="p">.</span><span class="n">batch_execute_statement</span><span class="p">(</span><span class="n">ClusterIdentifier</span><span class="o">=</span><span class="n">redshift_config</span><span class="p">[</span><span class="s">"redshift_cluster_id"</span><span class="p">]</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L28">
              <td class="line-num" data-linenumber="28">
                <span class="linked-line" unselectable="on" data-linenumber="28"></span>
              </td>
              
              <td class="line_content">                                                          <span class="p">,</span><span class="n">Database</span><span class="o">=</span><span class="n">redshift_config</span><span class="p">[</span><span class="s">"redshift_database"</span><span class="p">]</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L29">
              <td class="line-num" data-linenumber="29">
                <span class="linked-line" unselectable="on" data-linenumber="29"></span>
              </td>
              
              <td class="line_content">                                                          <span class="p">,</span><span class="n">DbUser</span><span class="o">=</span><span class="n">redshift_config</span><span class="p">[</span><span class="s">"redshift_user"</span><span class="p">]</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L30">
              <td class="line-num" data-linenumber="30">
                <span class="linked-line" unselectable="on" data-linenumber="30"></span>
              </td>
              
              <td class="line_content">                                                          <span class="p">,</span><span class="n">Sqls</span><span class="o">=</span><span class="n">sql_statements</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L31">
              <td class="line-num" data-linenumber="31">
                <span class="linked-line" unselectable="on" data-linenumber="31"></span>
              </td>
              
              <td class="line_content">                                                          <span class="p">,</span><span class="n">StatementName</span><span class="o">=</span><span class="n">statement_name</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L32">
              <td class="line-num" data-linenumber="32">
                <span class="linked-line" unselectable="on" data-linenumber="32"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L33">
              <td class="line-num" data-linenumber="33">
                <span class="linked-line" unselectable="on" data-linenumber="33"></span>
              </td>
              
              <td class="line_content">    <span class="c1"># return the sql_batch_id (a universally unique identifier generated by Amazon Redshift Data API)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L34">
              <td class="line-num" data-linenumber="34">
                <span class="linked-line" unselectable="on" data-linenumber="34"></span>
              </td>
              
              <td class="line_content">    <span class="n">sql_batch_id</span> <span class="o">=</span> <span class="n">api_response</span><span class="p">[</span><span class="s">"Id"</span><span class="p">]</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L35">
              <td class="line-num" data-linenumber="35">
                <span class="linked-line" unselectable="on" data-linenumber="35"></span>
              </td>
              
              <td class="line_content">    <span class="k">return</span> <span class="n">sql_batch_id</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L36">
              <td class="line-num" data-linenumber="36">
                <span class="linked-line" unselectable="on" data-linenumber="36"></span>
              </td>
              
              <td class="line_content">    
</td>
            </tr>
          
            
            <tr class="line_holder" id="L37">
              <td class="line-num" data-linenumber="37">
                <span class="linked-line" unselectable="on" data-linenumber="37"></span>
              </td>
              
              <td class="line_content"><span class="k">def</span> <span class="nf">get_sql_status</span><span class="p">(</span><span class="n">sql_id</span><span class="p">):</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L38">
              <td class="line-num" data-linenumber="38">
                <span class="linked-line" unselectable="on" data-linenumber="38"></span>
              </td>
              
              <td class="line_content">    <span class="n">desc</span> <span class="o">=</span> <span class="n">redshift_client</span><span class="p">.</span><span class="n">describe_statement</span><span class="p">(</span><span class="n">Id</span><span class="o">=</span><span class="n">sql_id</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L39">
              <td class="line-num" data-linenumber="39">
                <span class="linked-line" unselectable="on" data-linenumber="39"></span>
              </td>
              
              <td class="line_content">    <span class="n">status</span> <span class="o">=</span> <span class="n">desc</span><span class="p">[</span><span class="s">"Status"</span><span class="p">]</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L40">
              <td class="line-num" data-linenumber="40">
                <span class="linked-line" unselectable="on" data-linenumber="40"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L41">
              <td class="line-num" data-linenumber="41">
                <span class="linked-line" unselectable="on" data-linenumber="41"></span>
              </td>
              
              <td class="line_content">    <span class="k">if</span> <span class="n">status</span> <span class="o">==</span> <span class="s">"FAILED"</span><span class="p">:</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L42">
              <td class="line-num" data-linenumber="42">
                <span class="linked-line" unselectable="on" data-linenumber="42"></span>
              </td>
              
              <td class="line_content">        <span class="k">raise</span> <span class="nb">Exception</span><span class="p">(</span><span class="s">'SQL query failed:'</span> <span class="o">+</span> <span class="n">sql_id</span> <span class="o">+</span> <span class="s">": "</span> <span class="o">+</span> <span class="n">desc</span><span class="p">[</span><span class="s">"Error"</span><span class="p">])</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L43">
              <td class="line-num" data-linenumber="43">
                <span class="linked-line" unselectable="on" data-linenumber="43"></span>
              </td>
              
              <td class="line_content">    <span class="k">return</span> <span class="n">status</span><span class="p">.</span><span class="n">strip</span><span class="p">(</span><span class="s">'"'</span><span class="p">)</span>         
</td>
            </tr>
          
            
            <tr class="line_holder" id="L44">
              <td class="line-num" data-linenumber="44">
                <span class="linked-line" unselectable="on" data-linenumber="44"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L45">
              <td class="line-num" data-linenumber="45">
                <span class="linked-line" unselectable="on" data-linenumber="45"></span>
              </td>
              
              <td class="line_content"><span class="k">def</span> <span class="nf">handler</span><span class="p">(</span><span class="n">event</span><span class="p">,</span> <span class="n">context</span><span class="p">):</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L46">
              <td class="line-num" data-linenumber="46">
                <span class="linked-line" unselectable="on" data-linenumber="46"></span>
              </td>
              
              <td class="line_content">    <span class="c1"># action to be taken by the lambda function. </span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L47">
              <td class="line-num" data-linenumber="47">
                <span class="linked-line" unselectable="on" data-linenumber="47"></span>
              </td>
              
              <td class="line_content">    <span class="c1"># Allowed values: [setup_sales_data_pipeline, run_sales_data_pipeline, get_sql_status"]</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L48">
              <td class="line-num" data-linenumber="48">
                <span class="linked-line" unselectable="on" data-linenumber="48"></span>
              </td>
              
              <td class="line_content">    <span class="n">action</span> <span class="o">=</span> <span class="n">event</span><span class="p">[</span><span class="s">'Input'</span><span class="p">].</span><span class="n">get</span><span class="p">(</span><span class="s">'action'</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L49">
              <td class="line-num" data-linenumber="49">
                <span class="linked-line" unselectable="on" data-linenumber="49"></span>
              </td>
              
              <td class="line_content">    
</td>
            </tr>
          
            
            <tr class="line_holder" id="L50">
              <td class="line-num" data-linenumber="50">
                <span class="linked-line" unselectable="on" data-linenumber="50"></span>
              </td>
              
              <td class="line_content">    <span class="k">try</span><span class="p">:</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L51">
              <td class="line-num" data-linenumber="51">
                <span class="linked-line" unselectable="on" data-linenumber="51"></span>
              </td>
              
              <td class="line_content">        <span class="k">if</span> <span class="n">action</span> <span class="ow">in</span> <span class="p">(</span><span class="s">'setup_sales_data_pipeline'</span><span class="p">,</span><span class="s">'run_sales_data_pipeline'</span><span class="p">):</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L52">
              <td class="line-num" data-linenumber="52">
                <span class="linked-line" unselectable="on" data-linenumber="52"></span>
              </td>
              
              <td class="line_content">            <span class="n">redshift_config</span> <span class="o">=</span> <span class="p">{}</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L53">
              <td class="line-num" data-linenumber="53">
                <span class="linked-line" unselectable="on" data-linenumber="53"></span>
              </td>
              
              <td class="line_content">            
</td>
            </tr>
          
            
            <tr class="line_holder" id="L54">
              <td class="line-num" data-linenumber="54">
                <span class="linked-line" unselectable="on" data-linenumber="54"></span>
              </td>
              
              <td class="line_content">            <span class="c1"># Get Database Credentials</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L55">
              <td class="line-num" data-linenumber="55">
                <span class="linked-line" unselectable="on" data-linenumber="55"></span>
              </td>
              
              <td class="line_content">            <span class="c1"># cluster identifier for the Amazon Redshift cluster</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L56">
              <td class="line-num" data-linenumber="56">
                <span class="linked-line" unselectable="on" data-linenumber="56"></span>
              </td>
              
              <td class="line_content">            <span class="n">redshift_config</span><span class="p">[</span><span class="s">"redshift_cluster_id"</span><span class="p">]</span> <span class="o">=</span> <span class="n">os</span><span class="p">.</span><span class="n">getenv</span><span class="p">(</span><span class="s">'redshift_cluster_identifier'</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L57">
              <td class="line-num" data-linenumber="57">
                <span class="linked-line" unselectable="on" data-linenumber="57"></span>
              </td>
              
              <td class="line_content">            <span class="c1"># database name for the Amazon Redshift cluster</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L58">
              <td class="line-num" data-linenumber="58">
                <span class="linked-line" unselectable="on" data-linenumber="58"></span>
              </td>
              
              <td class="line_content">            <span class="n">redshift_config</span><span class="p">[</span><span class="s">"redshift_database"</span><span class="p">]</span> <span class="o">=</span> <span class="n">os</span><span class="p">.</span><span class="n">getenv</span><span class="p">(</span><span class="s">'redshift_database_name'</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L59">
              <td class="line-num" data-linenumber="59">
                <span class="linked-line" unselectable="on" data-linenumber="59"></span>
              </td>
              
              <td class="line_content">            <span class="c1"># database user in the Amazon Redshift cluster with access to execute relevant SQL queries</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L60">
              <td class="line-num" data-linenumber="60">
                <span class="linked-line" unselectable="on" data-linenumber="60"></span>
              </td>
              
              <td class="line_content">            <span class="n">redshift_config</span><span class="p">[</span><span class="s">"redshift_user"</span><span class="p">]</span> <span class="o">=</span> <span class="n">os</span><span class="p">.</span><span class="n">getenv</span><span class="p">(</span><span class="s">'redshift_database_user'</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L61">
              <td class="line-num" data-linenumber="61">
                <span class="linked-line" unselectable="on" data-linenumber="61"></span>
              </td>
              
              <td class="line_content">            
</td>
            </tr>
          
            
            <tr class="line_holder" id="L62">
              <td class="line-num" data-linenumber="62">
                <span class="linked-line" unselectable="on" data-linenumber="62"></span>
              </td>
              
              <td class="line_content">            <span class="c1"># Get details to run the script</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L63">
              <td class="line-num" data-linenumber="63">
                <span class="linked-line" unselectable="on" data-linenumber="63"></span>
              </td>
              
              <td class="line_content">            <span class="n">job_run_date</span> <span class="o">=</span> <span class="n">os</span><span class="p">.</span><span class="n">getenv</span><span class="p">(</span><span class="s">'job_run_date'</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L64">
              <td class="line-num" data-linenumber="64">
                <span class="linked-line" unselectable="on" data-linenumber="64"></span>
              </td>
              
              <td class="line_content">            <span class="n">etl_script_s3_path</span> <span class="o">=</span> <span class="n">event</span><span class="p">[</span><span class="s">'Input'</span><span class="p">].</span><span class="n">get</span><span class="p">(</span><span class="s">'etl_script_s3_path'</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L65">
              <td class="line-num" data-linenumber="65">
                <span class="linked-line" unselectable="on" data-linenumber="65"></span>
              </td>
              
              <td class="line_content">            <span class="n">sql_statements</span> <span class="o">=</span> <span class="n">split_sql_statement</span><span class="p">(</span><span class="n">etl_script_s3_path</span><span class="p">,</span> <span class="n">job_run_date</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L66">
              <td class="line-num" data-linenumber="66">
                <span class="linked-line" unselectable="on" data-linenumber="66"></span>
              </td>
              
              <td class="line_content">            <span class="n">statement_name</span> <span class="o">=</span> <span class="n">Path</span><span class="p">(</span><span class="n">etl_script_s3_path</span><span class="p">).</span><span class="n">name</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L67">
              <td class="line-num" data-linenumber="67">
                <span class="linked-line" unselectable="on" data-linenumber="67"></span>
              </td>
              
              <td class="line_content">            
</td>
            </tr>
          
            
            <tr class="line_holder" id="L68">
              <td class="line-num" data-linenumber="68">
                <span class="linked-line" unselectable="on" data-linenumber="68"></span>
              </td>
              
              <td class="line_content">            <span class="c1"># execute the input SQL statement in the specified Amazon Redshift cluster</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L69">
              <td class="line-num" data-linenumber="69">
                <span class="linked-line" unselectable="on" data-linenumber="69"></span>
              </td>
              
              <td class="line_content">            <span class="n">sql_batch_id</span> <span class="o">=</span> <span class="n">run_batch_sql</span><span class="p">(</span><span class="n">redshift_config</span><span class="p">,</span> <span class="n">sql_statements</span><span class="p">,</span> <span class="n">statement_name</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L70">
              <td class="line-num" data-linenumber="70">
                <span class="linked-line" unselectable="on" data-linenumber="70"></span>
              </td>
              
              <td class="line_content">            <span class="n">api_response</span> <span class="o">=</span> <span class="p">{</span><span class="s">'sql_batch_id'</span><span class="p">:</span> <span class="n">sql_batch_id</span><span class="p">}</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L71">
              <td class="line-num" data-linenumber="71">
                <span class="linked-line" unselectable="on" data-linenumber="71"></span>
              </td>
              
              <td class="line_content">        <span class="k">elif</span> <span class="n">action</span> <span class="o">==</span> <span class="s">"get_sql_status"</span><span class="p">:</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L72">
              <td class="line-num" data-linenumber="72">
                <span class="linked-line" unselectable="on" data-linenumber="72"></span>
              </td>
              
              <td class="line_content">            <span class="c1"># sql_batch_id to input for action get_sql_status</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L73">
              <td class="line-num" data-linenumber="73">
                <span class="linked-line" unselectable="on" data-linenumber="73"></span>
              </td>
              
              <td class="line_content">            <span class="n">sql_batch_id</span> <span class="o">=</span> <span class="n">event</span><span class="p">[</span><span class="s">'Input'</span><span class="p">].</span><span class="n">get</span><span class="p">(</span><span class="s">'sql_batch_id'</span><span class="p">)</span>            
</td>
            </tr>
          
            
            <tr class="line_holder" id="L74">
              <td class="line-num" data-linenumber="74">
                <span class="linked-line" unselectable="on" data-linenumber="74"></span>
              </td>
              
              <td class="line_content">            <span class="c1"># get status of a previously executed data api call</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L75">
              <td class="line-num" data-linenumber="75">
                <span class="linked-line" unselectable="on" data-linenumber="75"></span>
              </td>
              
              <td class="line_content">            <span class="n">api_status</span> <span class="o">=</span> <span class="n">get_sql_status</span><span class="p">(</span><span class="n">sql_batch_id</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L76">
              <td class="line-num" data-linenumber="76">
                <span class="linked-line" unselectable="on" data-linenumber="76"></span>
              </td>
              
              <td class="line_content">            
</td>
            </tr>
          
            
            <tr class="line_holder" id="L77">
              <td class="line-num" data-linenumber="77">
                <span class="linked-line" unselectable="on" data-linenumber="77"></span>
              </td>
              
              <td class="line_content">            <span class="n">api_response</span> <span class="o">=</span> <span class="p">{</span><span class="s">'status'</span><span class="p">:</span> <span class="n">api_status</span><span class="p">}</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L78">
              <td class="line-num" data-linenumber="78">
                <span class="linked-line" unselectable="on" data-linenumber="78"></span>
              </td>
              
              <td class="line_content">        <span class="k">else</span><span class="p">:</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L79">
              <td class="line-num" data-linenumber="79">
                <span class="linked-line" unselectable="on" data-linenumber="79"></span>
              </td>
              
              <td class="line_content">            <span class="k">raise</span> <span class="nb">ValueError</span><span class="p">(</span><span class="s">"Invalid Action: "</span> <span class="o">+</span> <span class="n">action</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L80">
              <td class="line-num" data-linenumber="80">
                <span class="linked-line" unselectable="on" data-linenumber="80"></span>
              </td>
              
              <td class="line_content">    <span class="k">except</span> <span class="nb">NameError</span> <span class="k">as</span> <span class="n">error</span><span class="p">:</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L81">
              <td class="line-num" data-linenumber="81">
                <span class="linked-line" unselectable="on" data-linenumber="81"></span>
              </td>
              
              <td class="line_content">        <span class="k">raise</span> <span class="nb">NameError</span><span class="p">(</span><span class="n">error</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L82">
              <td class="line-num" data-linenumber="82">
                <span class="linked-line" unselectable="on" data-linenumber="82"></span>
              </td>
              
              <td class="line_content">    <span class="k">except</span> <span class="nb">Exception</span> <span class="k">as</span> <span class="n">exception</span><span class="p">:</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L83">
              <td class="line-num" data-linenumber="83">
                <span class="linked-line" unselectable="on" data-linenumber="83"></span>
              </td>
              
              <td class="line_content">        <span class="n">error_message</span> <span class="o">=</span> <span class="s">"Encountered exeption on:"</span> <span class="o">+</span> <span class="n">action</span> <span class="o">+</span> <span class="s">":"</span> <span class="o">+</span> <span class="nb">str</span><span class="p">(</span><span class="n">exception</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L84">
              <td class="line-num" data-linenumber="84">
                <span class="linked-line" unselectable="on" data-linenumber="84"></span>
              </td>
              
              <td class="line_content">        <span class="k">raise</span> <span class="nb">Exception</span><span class="p">(</span><span class="n">error_message</span><span class="p">)</span>          
</td>
            </tr>
          
            
            <tr class="line_holder" id="L85">
              <td class="line-num" data-linenumber="85">
                <span class="linked-line" unselectable="on" data-linenumber="85"></span>
              </td>
              
              <td class="line_content">    <span class="k">return</span> <span class="n">api_response</span>
</td>
            </tr>
          
        </tbody>
      </table>
    </div>
  

</div>
</div>


</div>
<nav class='navbar navbar-default footer' role='navigation'>
<footer class='footer top-buffer' id='footer'>
<div class='col-sm-9 col-md-8 main'>
<h3>Packages</h3>
<ul class='unstyled'>
<li><a href="https://octane.amazon.com/package">Create Package</a></li>
<li><a href="/packages/find_by_team_for_user">All packages for my team</a></li>
</ul>
<h3>Commit Notifications</h3>
<ul class='unstyled'>
<li><a href="https://w.amazon.com/index.php/BuilderTools/Product/RevisionControl/CommitNotifications">RSS</a></li>
<li><a href="/commit-notifications">Email</a></li>
</ul>
</div>
<div class='col-sm-3 col-md-4 sidebar'>
<div class='business_card clearfix'>
<h3>Need help?</h3>
<ul class='unstyled'>
<li><a target="_blank" href="https://tiny.amazon.com/1bxu90lx3/codeacbug">Submit an Issue (problems or suggestions)</a></li>
<li><a target="_blank" href="https://builderhub.corp.amazon.com/tools/products-code-browser.html">Code Browser Documentation</a></li>
<li><a target="_blank" href="https://builderhub.corp.amazon.com/tools/crux/index.html">CRUX Documentation</a></li>
<li><a target="_blank" href="https://builderhub.corp.amazon.com//docs/code-browser/user-guide/code-search.html">Code Search Documentation</a></li>
<li><a target="_blank" href="https://w.amazon.com/index.php/DTUX/Browser_Support_Policy">Browser Support Policy</a></li>
</ul>
</div>
</div>
</footer>
</nav>

<script>
  var codeBrowserSpoofedUser = 'pedrezaj'
</script>
<script src="https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/vendor-part1-cbfcefdd48a040ef97f5f68679e9f7b25778f27f104c8a9dc3bcd7657beaf2c4.js"></script>
<script src="https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/vendor-part2-6bc8927fb64933e5b33c9713f1442541bb830245764ffedd64bd5c33bb428217.js"></script>
<script src="https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/vendor-part3-7ebd7179046ca7f16256f9098d3160938eb0b9e871015ae6f2b2b94ae73669db.js"></script>
<script src="https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/vendor-part4-17bb2fe46496199e4ee24cf7515256f1c5c0b04382ecb875cb6ed8630839ea2f.js"></script>
<script src="https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/application-11087d592b3c8b75a6056a8defabd9ac70c8c112656cfd5aa5b1fe1d7e20fffb.js"></script>
<script src="https://internal-cdn.amazon.com/is-it-down.amazon.com/javascripts/stripe.min.js"></script>
<script>
  (function() {
    if (typeof isItDownStripe === 'function') {
      $(function() {
        return isItDownStripe('sourcecode', 1107, 1);
      });
    }
  
  }).call(this);
</script>
<script src="https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/application_angular-91842533ce2de5c824774b8a2cf794fd84f44dddd1524f342485ccfc46fec887.js"></script>
<script>
  bootstrapNgApp('code-browser', 'markdown');
</script>
<script>
  $(document).ready(function() {
      $('#branches').select2({
          width: "274px",
          data: [{"text":"This Commit's Parents","children":[{"text":"28a67ed6^1 (cc439589)","id":"/packages/Amazon-redshift-data-api-getting-started/blobs/cc439589df2c0d50b6965e6e41f6da2e80a64931/--/use-cases/etl-orchestration-with-lambda-and-step-functions/code/redshift_batch_data_api.py"}]},{"text":"Official Branches","children":[{"text":"dev-general-readme","id":"/packages/Amazon-redshift-data-api-getting-started/blobs/heads/dev-general-readme/--/use-cases/etl-orchestration-with-lambda-and-step-functions/code/redshift_batch_data_api.py"},{"text":"dev-java","id":"/packages/Amazon-redshift-data-api-getting-started/blobs/heads/dev-java/--/use-cases/etl-orchestration-with-lambda-and-step-functions/code/redshift_batch_data_api.py"},{"text":"mainline (default)","id":"/packages/Amazon-redshift-data-api-getting-started/blobs/heads/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/code/redshift_batch_data_api.py"}]}],
          createSearchChoice: function(term, data) {
            if ($(data).filter(function() { return this.text.localeCompare(term)===0; }).length===0) {
              // This code fires if the user enters a string and hits return (rather than selecting the item
              // from the dropdown.  This breaks when viewing commits (logs). Customize it accordingly.
              if ('/packages/Amazon-redshift-data-api-getting-started/blobs/'.match(/\/logs/)) {
                var id_string = '/packages/Amazon-redshift-data-api-getting-started/blobs//' + term;
                if ('use-cases/etl-orchestration-with-lambda-and-step-functions/code/redshift_batch_data_api.py') {
                  id_string += '/--/use-cases/etl-orchestration-with-lambda-and-step-functions/code/redshift_batch_data_api.py';
                }
                return {text:term, id: id_string};
              }
              return {text:term, id:'/packages/Amazon-redshift-data-api-getting-started/blobs/' + term + '/--/use-cases/etl-orchestration-with-lambda-and-step-functions/code/redshift_batch_data_api.py'};
            }
          },
      });
      $('#branches').select2('data', null);
      $('#branches').change(function() {
        document.location = $(this).val();
      });
  });
</script>
<script>
  (function() {
    $(function() {
      return $('.add_relation_link a').click(function() {
        $('.add_related_items').show(500).find('input[name=relation]').delay(500).focus();
        $(this).hide();
        return false;
      });
    });
  
  }).call(this);
</script>
<script>
  (function() {
    $(function() {
      return $('.commit-see-more').click(function() {
        $('.commit-see-more').text($('.commit-see-more').text() === 'see more' ? 'see less' : 'see more');
        $('.last-commit-summary').toggle();
        $('.commit_header').toggleClass('show_commit_header');
        return false;
      });
    });
  
  }).call(this);
</script>
<script>
  (function() {
    $('li.permalink a').click(function() {
      window.location.href = this.href + location.hash;
      return false;
    });
  
  }).call(this);
</script>
<script>
  (function() {
    var relatedItems;
  
    relatedItems = new Codac.RelatedItemsModel('Amazon-redshift-data-api-getting-started', '28a67ed63469e767ff917f71d9697275aa578490', 'mainline', '');
  
    Codac.model.relatedItemsModel(relatedItems);
  
  }).call(this);
</script>
<script>
  (function() {
    var onUrlChange, premalinkBtnEl, premalinkPath;
  
    (function() {
      var anchor, anchorMatch, hash, hl_lines_match, path, ranges, search;
      anchor = window.location.hash.split('#')[1] || '';
      anchorMatch = anchor.match(/^line-(\d+)/);
      if (anchorMatch) {
        anchor = 'L' + anchorMatch[1];
      }
      search = window.location.search;
      hl_lines_match = search.match(/hl_lines=([\d\-\,]+)/);
      ranges = '';
      if (hl_lines_match) {
        ranges = hl_lines_match[1].split(',').map(function(range) {
          return range.split('-').map(function(lineNum) {
            return 'L' + lineNum;
          }).join('-');
        }).join(',');
      }
      hash = ranges;
      if (anchorMatch) {
        hash += '|' + anchor;
      }
      if (hash !== '') {
        if (hash !== '') {
          window.location.hash = '#' + hash;
        }
        path = window.location.pathname + window.location.hash;
        return window.history.pushState(void 0, void 0, path);
      }
    })();
  
    premalinkBtnEl = $('#file_actions .permalink');
  
    premalinkPath = premalinkBtnEl.find('.minibutton').attr('href');
  
    onUrlChange = function() {
      return premalinkBtnEl.hide();
    };
  
    setTimeout((function() {
      return (new Diff()).enableHighlighting({
        basePath: premalinkPath,
        onUrlChange: onUrlChange
      });
    }), 0);
  
  }).call(this);
</script>
<script src="https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/blame-f88c6e07c85e28bd45aab26237632f0d188ddabfb015c65edef9336a23c07758.js"></script>
<script>
  (function() {
    $(function() {
      var b;
      Codac.CommitHover.setupHover('.blameLine .powertip');
      b = new Codac.Blame({
        "package": 'Amazon-redshift-data-api-getting-started',
        sha1: '28a67ed63469e767ff917f71d9697275aa578490',
        path: 'use-cases/etl-orchestration-with-lambda-and-step-functions/code/redshift_batch_data_api.py',
        show: 'false'
      });
      return b.doBlame();
    });
  
  }).call(this);
</script>
<script>
  (function() {
    $(function() {
      $('.navbar-search.navbar-form').submit(function() {
        $(this).submit(function(e) {
          e.preventDefault();
          return false;
        });
        return $('.search-spinner').show();
      });
      return $('#tiny-link').click(function() {
        return $.getJSON('https://tiny.amazon.com/submit/url?opaque=1&name='.concat(encodeURIComponent(location.href)), function(data) {
          var $input, $link, $successful;
          if (data.error != null) {
            return $('#tiny-link').html($('<div class="red">' + data.error + '</div>'));
          } else {
            $link = data.short_url;
            $input = document.createElement('textarea');
            $input.innerHTML = $link;
            document.body.appendChild($input);
            $input.select();
            $successful = document.execCommand("copy");
            document.body.removeChild($input);
            if ($successful) {
              $('#tiny-link').html('Tiny Link Copied');
            } else {
              $('#tiny-link').html($('<div class="red"> Copy Tiny Link failed </div>'));
            }
            return setTimeout(function() {
              return $('#tiny-link').html('Tiny Link');
            }, 5000);
          }
        });
      });
    });
  
  }).call(this);
</script>

</body>
</html>
