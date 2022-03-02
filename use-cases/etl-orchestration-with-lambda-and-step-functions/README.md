<!DOCTYPE html>
<html>
<head>
<title>README.md - Amazon-redshift-data-api-getting-started - Code Browser</title>
<meta content='width=device-width, initial-scale=1' name='viewport'>
<meta content='true' name='use-sentry'>
<meta content='9ceb4ff3-7c15-45c4-beb8-f180da39f876' name='request-id'>
<meta name="csrf-param" content="authenticity_token" />
<meta name="csrf-token" content="TR4eh1LQxNCboqCcCE3nxpFVVuao4qL20hFcbjBtmwtx9kB2E+dJbw2dywz5txPg4HfYZTDaw3ou2/6800ytgg==" />
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
<li class='.active'>README.md</li>


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
<input type="hidden" name="path" id="path" value="use-cases/etl-orchestration-with-lambda-and-step-functions/README.md" />
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
<li><a class="mono powertip autoselect" data-powertip="28a67ed63469e767ff917f71d9697275aa578490" data-commit-id="28a67ed63469e767ff917f71d9697275aa578490" href="/packages/Amazon-redshift-data-api-getting-started/commits/28a67ed63469e767ff917f71d9697275aa578490#use-cases/etl-orchestration-with-lambda-and-step-functions/README.md">28a67ed6</a></li>
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
<form action="/create_relation" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><input type="hidden" name="authenticity_token" value="G7IufGrEYusefQeBDtg8eO88RjDqc3HCu2beFx353aEnWnCNK/PvVIhCbBH/Ishenh7Is3JLEE5HrHzF/tjrKA==" />
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
mime_type: text/plain; charset=utf-8
-->
<div class='file_header'>
<div class='path_breadcrumbs'>
<div class='path_breadcrumbs'>
<span class='path_breadcrumb'><a href="/packages/Amazon-redshift-data-api-getting-started">Amazon-redshift-data-api-getting-started</a></span>/<span class='path_breadcrumb'><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/">mainline</a></span>/<span class='path_breadcrumb'><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/use-cases">use-cases</a></span>/<span class='path_breadcrumb'><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions">etl-orchestration-with-lambda-and-step-functions</a></span>/<span class='path_breadcrumb'>README.md</span>
</div>

</div>
<div class='hidden-print' id='file_actions'>
<ul class='button_group'>
<li>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/blobs/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/README.md?raw=1">Raw</a>
</li>
<li>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/blobs/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/README.md?download=1">Download</a>
</li>
<li>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/logs/mainline?path=use-cases%2Fetl-orchestration-with-lambda-and-step-functions%2FREADME.md">History</a>
</li>
<li>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/blobs/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/README.md/edit_file_online">Edit</a>
</li>
<li>
<a class="minibutton md_control_raw" href="#raw_markdown">Markdown Source</a>
</li>
<li>
<a class="minibutton md_control_rendered selected active" href="#">Rendered Markdown</a>
</li>
<li class='permalink'>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/blobs/28a67ed63469e767ff917f71d9697275aa578490/--/use-cases/etl-orchestration-with-lambda-and-step-functions/README.md">Permalink</a>
</li>
</ul>
</div>
<div class='clear'></div>
<markdown add-raw-if-needed='true'>
# ETL Orchestration using Amazon Redshift Data API and AWS Step Functions
The [Amazon Redshift Data API](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) is suitable for use cases where you don’t need a persistent connection to a cluster. One of its applicable use case is building your ETL pipelines with [AWS Step Functions](https://aws.amazon.com/step-functions/) and [AWS Lambda](https://aws.amazon.com/lambda/). In this AWS Sample code, you will learn how to use AWS Step Functions and Amazon Redshift Data API to orchestrate the different steps in your ETL/ELT workflow that loads data into [Amazon Redshift](https://aws.amazon.com/redshift/) data warehouse. 

In this solution, [AWS Step Functions](https://aws.amazon.com/step-functions/) uses the [AWS Lambda](https://aws.amazon.com/lambda/) function and [Amazon Redshift Data API](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) to setup the required database objects and generate a set of sample data to be processed. It then executes two dimension jobs that performs SCD1 and SCD2 dimension load respectively, and once both jobs have been executed successfully only then will the load job for the fact table execute. And finally as a last step, it performs a validation to ensure the sales data  was loaded successfully.
![ETL Workflow](images/etl_workflow.png)

In this example, `batch-execute-statement` is used to run multiple SQL statements in a batch as a part of a single transaction on the Amazon Redshift Data API. The SQL statements can be `SELECT`, `DML`, `DDL`, `COPY`, and `UNLOAD`. For more information, please checkout [BatchExecuteStatement API Documentation](https://docs.aws.amazon.com/redshift-data/latest/APIReference/API_BatchExecuteStatement.html). 

# Pre-requisites
As a pre-requisite for creating the application explained in this repo, you should need to setup an Amazon Redshift cluster and associate it with an AWS Identity and Access Management (IAM) [Role](https://docs.aws.amazon.com/redshift/latest/mgmt/authorizing-redshift-service.html). If you don’t have that provisioned in your AWS account, please follow Amazon Redshift getting started [guide](https://docs.aws.amazon.com/redshift/latest/gsg/getting-started.html) to set it up.

You will also need to download the following SQL scripts used in this solution and store them in your S3 bucket:

* [setup_sales_data_pipeline.sql](scripts/setup_sales_data_pipeline.sql) - Contains the steps to create the tables and populate with sample data
* [run_sales_data_pipeline.sql](scripts/run_sales_data_pipeline.sql) - Contains the steps to perform the ETL processing on the customer_address, item and sales tables

# Solution Architecture
The following architecture diagram highlights the end-to-end solution:
![Architecture Diagram](images/redshift_data_api_step_function_architecture.png)
In this sample, the triggering mechanism will be to [Start a new execution](https://docs.aws.amazon.com/step-functions/latest/dg/getting-started.html#start-new-execution) in the Step Functions console however AWS Step Functions can be executed in a number of ways as per the following:
* Call the [StartExecution](https://docs.aws.amazon.com/step-functions/latest/apireference/API_StartExecution.html) API action. 
* Use [Amazon CloudWatch Events](https://docs.aws.amazon.com/step-functions/latest/dg/tutorial-cloudwatch-events-s3.html) to start an execution. 
* Start an execution with [Amazon API Gateway](https://docs.aws.amazon.com/step-functions/latest/dg/tutorial-api-gateway.html). 
* Start a [nested workflow execution](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-nested-workflows.html) from a Task state. 

Solution can be deployed with the [Cloud Formation Template](cloud_formation_template/etl-orchestration-with-stepfunctions-and-redshift-data-api.yaml) that creates the below resources: 
1. Database objects in the Amazon Redshift cluster
	* Five Redshift tables - to be used by the ETL workflow 
		1. customer
		2. customer_address
		3. date_dim
		4. item
		5. store_sales
2. [AWS IAM Role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html), `LambdaRedshiftBatchDataAPIRole` for AWS Lambda to allow below permissions:
    * Federate to the Amazon Redshift cluster through `getClusterCredentials` permission avoiding password credentials.
    * Execute queries in Amazon Redshift cluster through Redshift Data API calls
    * Logging with AWS CloudWatch for troubleshooting purpose
    * List and retrieves objects from Amazon S3
3. [AWS IAM Role](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html), `StateMachineExecutionRole` for AWS Step Functions to allow below permissions:
    * Execute the `redshift_batch_data_api` lambda function within the Step Function
4. [AWS Lambda function](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html), `redshift_batch_data_api` is executed as soon as the Step Function is executed. The AWS Lambda function will execute SQL statements in Amazon Redshift leveraging the `redshift-data` client. Based on the input parameter `action` that is passed by the AWS Step Function, this lambda function can asynchronously execute Structured Query Language (SQL) statements in Amazon Redshift and thus avoid chances of timing-out in case of long running SQL statements. It uses [Amazon Redshift Data API&#39;s](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) temporary credentials functionality, which allows it to communicate with Amazon Redshift using AWS Identity and Access Management (IAM) permission, without the need of any password-based authentication. With Data API, there is also no need to configure drivers and connections for your Amazon Redshift cluster, which is handled automatically.

   As there are multiple SQL statements that needs to be executed as a part of a single transaction to ensure data integrity, these SQL statements will be executed in a batch using the [&quot;batch-execute-statement&quot; API.](https://docs.aws.amazon.com/redshift-data/latest/APIReference/API_BatchExecuteStatement.html)

5. [AWS Step Functions state machine](https://docs.aws.amazon.com/step-functions/latest/dg/welcome.html), `RedshiftETLStepFunction`, which contains the steps used to orchestrate AWS services and build serverless applications.

# Goal of the Archictecture  
1) Deploy Redshift Database Objects
2) Load a set of sample data 
3) Run the multi-step ETL process as per the defined job dependencies
4) Validate the data was processed successfully

# Steps
1. Once the [Cloud Formation Template](cloud_formation_template/etl-orchestration-with-stepfunctions-and-redshift-data-api.yaml) is deployed, go to the &quot;Resources&quot; and click on the Physical ID column of the `RedshiftETLStepFunction` in order to navigate to the [AWS Step Function](https://aws.amazon.com/step-functions/) console.
![CloudFormation Resources](images/cloudformation_resources.png)
2. Click the &quot;Start execution&quot; button using the default settings to execute the `RedshiftETLStepFunction` step function that allows you to visualize the execution of the ETL workflow in real time.
![StepFunction Execution](images/step_function_workflow_execution.png)

Below steps outlines the workflow:

1. `setup_sales_data_pipeline`
	* Invokes the `redshift_batch_data_api` lambda function and sends a `setup_sales_data_pipeline` action
	* Retrieves the [setup_sales_data_pipeline.sql](scripts/setup_sales_data_pipeline.sql) from S3 to get the SQL statements to be executed
	* Pass the SQL statements to the [&quot;batch-execute-statement&quot; API](https://docs.aws.amazon.com/redshift-data/latest/APIReference/API_BatchExecuteStatement.html) to run in the [Amazon Redshift](https://aws.amazon.com/redshift/) cluster
	* Sends back the identifier of the SQL statement to the step function 			
2. `wait_on_setup_sales_data_pipeline`
	* Waits for at least 10 seconds
3. `setup_sales_data_pipeline_status_check`
	* Invokes the `redshift_batch_data_api` lambda function and sends a `get_sql_status` action to get the status of the API call
4. `is_setup_sales_data_pipeline_complete` - routes the next step of the ETL workflow as per the following:
	* FINISHED - Execute the SQL statements to process the two dimension tables (customer_address and item) and one fact table (sales)
	* FAILED - Go to `sales_data_pipeline_failure` step and fail the ETL workflow
	* All other status - Go back to the `wait_on_setup_sales_data_pipeline` step to wait for the SQL statements to finish
	
5. `run_sales_data_pipeline`
	* Invokes the `redshift_batch_data_api` lambda function and sends a `run_sales_data_pipeline` action
	* Retrieves the [run_sales_data_pipeline.sql](scripts/run_sales_data_pipeline.sql) from S3 to get the SQL statements to be executed
	* Pass the SQL statements to the [&quot;batch-execute-statement&quot; API.](https://docs.aws.amazon.com/redshift-data/latest/APIReference/API_BatchExecuteStatement.html) to run in the [Amazon Redshift](https://aws.amazon.com/redshift/) cluster
	* Sends back the identifier of the SQL statement to the step function 			
6. `wait_on_run_sales_data_pipeline`
	* Waits for at least 10 seconds
7. `run_sales_data_pipeline_status_check`
	* Invokes the `redshift_batch_data_api` lambda function and sends a `get_sql_status` action to get the status of the API call
8. `is_run_sales_data_pipeline_complete` - routes the next step of the ETL workflow as per the following:
	* FINISHED - Go to `sales_data_pipeline_success` step and stop the ETL worklow
	* FAILED - Go to `sales_data_pipeline_failure` step and fail the ETL workflow
	* All other status - Go back to the `wait_on_run_sales_data_pipeline` step to wait for the SQL statements to finish			
		
**Note**: The implementation of the ETL workflow is idempotent. If it fails, you can retry the job without any cleanup. For example, it recreates the `stg_store_sales` table each time, then deletes target table `store_sales` with the data for the particular refresh date each time.

# Validation
The entire ETL workflow takes around 1 minute to run and you should see the following diagram when the ETL workflow execution completed successfully.



![StepFunction WorkflowSuccess](images/sales_data_pipeline_step_function_workflow.png)
</markdown>
<div class='blob hidden-print highlighttable markdown_source' ng_non_bindable>
  
    <div class="js-syntax-highlight-wrapper">
      <table class="code js-syntax-highlight">
        <tbody>
          
            
            <tr class="line_holder" id="L1">
              <td class="line-num" data-linenumber="1">
                <span class="linked-line" unselectable="on" data-linenumber="1"></span>
              </td>
              
              <td class="line_content"><span class="gh"># ETL Orchestration using Amazon Redshift Data API and AWS Step Functions</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L2">
              <td class="line-num" data-linenumber="2">
                <span class="linked-line" unselectable="on" data-linenumber="2"></span>
              </td>
              
              <td class="line_content">The <span class="p">[</span><span class="nv">Amazon Redshift Data API</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html</span><span class="p">)</span> is suitable for use cases where you don’t need a persistent connection to a cluster. One of its applicable use case is building your ETL pipelines with <span class="p">[</span><span class="nv">AWS Step Functions</span><span class="p">](</span><span class="sx">https://aws.amazon.com/step-functions/</span><span class="p">)</span> and <span class="p">[</span><span class="nv">AWS Lambda</span><span class="p">](</span><span class="sx">https://aws.amazon.com/lambda/</span><span class="p">)</span>. In this AWS Sample code, you will learn how to use AWS Step Functions and Amazon Redshift Data API to orchestrate the different steps in your ETL/ELT workflow that loads data into <span class="p">[</span><span class="nv">Amazon Redshift</span><span class="p">](</span><span class="sx">https://aws.amazon.com/redshift/</span><span class="p">)</span> data warehouse. 
</td>
            </tr>
          
            
            <tr class="line_holder" id="L3">
              <td class="line-num" data-linenumber="3">
                <span class="linked-line" unselectable="on" data-linenumber="3"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L4">
              <td class="line-num" data-linenumber="4">
                <span class="linked-line" unselectable="on" data-linenumber="4"></span>
              </td>
              
              <td class="line_content">In this solution, <span class="p">[</span><span class="nv">AWS Step Functions</span><span class="p">](</span><span class="sx">https://aws.amazon.com/step-functions/</span><span class="p">)</span> uses the <span class="p">[</span><span class="nv">AWS Lambda</span><span class="p">](</span><span class="sx">https://aws.amazon.com/lambda/</span><span class="p">)</span> function and <span class="p">[</span><span class="nv">Amazon Redshift Data API</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html</span><span class="p">)</span> to setup the required database objects and generate a set of sample data to be processed. It then executes two dimension jobs that performs SCD1 and SCD2 dimension load respectively, and once both jobs have been executed successfully only then will the load job for the fact table execute. And finally as a last step, it performs a validation to ensure the sales data  was loaded successfully.
</td>
            </tr>
          
            
            <tr class="line_holder" id="L5">
              <td class="line-num" data-linenumber="5">
                <span class="linked-line" unselectable="on" data-linenumber="5"></span>
              </td>
              
              <td class="line_content"><span class="p">![</span><span class="nv">ETL Workflow</span><span class="p">](</span><span class="sx">images/etl_workflow.png</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L6">
              <td class="line-num" data-linenumber="6">
                <span class="linked-line" unselectable="on" data-linenumber="6"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L7">
              <td class="line-num" data-linenumber="7">
                <span class="linked-line" unselectable="on" data-linenumber="7"></span>
              </td>
              
              <td class="line_content">In this example, <span class="sb">`batch-execute-statement`</span> is used to run multiple SQL statements in a batch as a part of a single transaction on the Amazon Redshift Data API. The SQL statements can be <span class="sb">`SELECT`</span>, <span class="sb">`DML`</span>, <span class="sb">`DDL`</span>, <span class="sb">`COPY`</span>, and <span class="sb">`UNLOAD`</span>. For more information, please checkout <span class="p">[</span><span class="nv">BatchExecuteStatement API Documentation</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/redshift-data/latest/APIReference/API_BatchExecuteStatement.html</span><span class="p">)</span>. 
</td>
            </tr>
          
            
            <tr class="line_holder" id="L8">
              <td class="line-num" data-linenumber="8">
                <span class="linked-line" unselectable="on" data-linenumber="8"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L9">
              <td class="line-num" data-linenumber="9">
                <span class="linked-line" unselectable="on" data-linenumber="9"></span>
              </td>
              
              <td class="line_content"><span class="gh"># Pre-requisites</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L10">
              <td class="line-num" data-linenumber="10">
                <span class="linked-line" unselectable="on" data-linenumber="10"></span>
              </td>
              
              <td class="line_content">As a pre-requisite for creating the application explained in this repo, you should need to setup an Amazon Redshift cluster and associate it with an AWS Identity and Access Management (IAM) <span class="p">[</span><span class="nv">Role</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/redshift/latest/mgmt/authorizing-redshift-service.html</span><span class="p">)</span>. If you don’t have that provisioned in your AWS account, please follow Amazon Redshift getting started <span class="p">[</span><span class="nv">guide</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/redshift/latest/gsg/getting-started.html</span><span class="p">)</span> to set it up.
</td>
            </tr>
          
            
            <tr class="line_holder" id="L11">
              <td class="line-num" data-linenumber="11">
                <span class="linked-line" unselectable="on" data-linenumber="11"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L12">
              <td class="line-num" data-linenumber="12">
                <span class="linked-line" unselectable="on" data-linenumber="12"></span>
              </td>
              
              <td class="line_content">You will also need to download the following SQL scripts used in this solution and store them in your S3 bucket:
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
              
              <td class="line_content"><span class="p">*</span> <span class="p">[</span><span class="nv">setup_sales_data_pipeline.sql</span><span class="p">](</span><span class="sx">scripts/setup_sales_data_pipeline.sql</span><span class="p">)</span> - Contains the steps to create the tables and populate with sample data
</td>
            </tr>
          
            
            <tr class="line_holder" id="L15">
              <td class="line-num" data-linenumber="15">
                <span class="linked-line" unselectable="on" data-linenumber="15"></span>
              </td>
              
              <td class="line_content"><span class="p">*</span> <span class="p">[</span><span class="nv">run_sales_data_pipeline.sql</span><span class="p">](</span><span class="sx">scripts/run_sales_data_pipeline.sql</span><span class="p">)</span> - Contains the steps to perform the ETL processing on the customer_address, item and sales tables
</td>
            </tr>
          
            
            <tr class="line_holder" id="L16">
              <td class="line-num" data-linenumber="16">
                <span class="linked-line" unselectable="on" data-linenumber="16"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L17">
              <td class="line-num" data-linenumber="17">
                <span class="linked-line" unselectable="on" data-linenumber="17"></span>
              </td>
              
              <td class="line_content"><span class="gh"># Solution Architecture</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L18">
              <td class="line-num" data-linenumber="18">
                <span class="linked-line" unselectable="on" data-linenumber="18"></span>
              </td>
              
              <td class="line_content">The following architecture diagram highlights the end-to-end solution:
</td>
            </tr>
          
            
            <tr class="line_holder" id="L19">
              <td class="line-num" data-linenumber="19">
                <span class="linked-line" unselectable="on" data-linenumber="19"></span>
              </td>
              
              <td class="line_content"><span class="p">![</span><span class="nv">Architecture Diagram</span><span class="p">](</span><span class="sx">images/redshift_data_api_step_function_architecture.png</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L20">
              <td class="line-num" data-linenumber="20">
                <span class="linked-line" unselectable="on" data-linenumber="20"></span>
              </td>
              
              <td class="line_content">In this sample, the triggering mechanism will be to <span class="p">[</span><span class="nv">Start a new execution</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/step-functions/latest/dg/getting-started.html#start-new-execution</span><span class="p">)</span> in the Step Functions console however AWS Step Functions can be executed in a number of ways as per the following:
</td>
            </tr>
          
            
            <tr class="line_holder" id="L21">
              <td class="line-num" data-linenumber="21">
                <span class="linked-line" unselectable="on" data-linenumber="21"></span>
              </td>
              
              <td class="line_content"><span class="p">*</span> Call the <span class="p">[</span><span class="nv">StartExecution</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/step-functions/latest/apireference/API_StartExecution.html</span><span class="p">)</span> API action. 
</td>
            </tr>
          
            
            <tr class="line_holder" id="L22">
              <td class="line-num" data-linenumber="22">
                <span class="linked-line" unselectable="on" data-linenumber="22"></span>
              </td>
              
              <td class="line_content"><span class="p">*</span> Use <span class="p">[</span><span class="nv">Amazon CloudWatch Events</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/step-functions/latest/dg/tutorial-cloudwatch-events-s3.html</span><span class="p">)</span> to start an execution. 
</td>
            </tr>
          
            
            <tr class="line_holder" id="L23">
              <td class="line-num" data-linenumber="23">
                <span class="linked-line" unselectable="on" data-linenumber="23"></span>
              </td>
              
              <td class="line_content"><span class="p">*</span> Start an execution with <span class="p">[</span><span class="nv">Amazon API Gateway</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/step-functions/latest/dg/tutorial-api-gateway.html</span><span class="p">)</span>. 
</td>
            </tr>
          
            
            <tr class="line_holder" id="L24">
              <td class="line-num" data-linenumber="24">
                <span class="linked-line" unselectable="on" data-linenumber="24"></span>
              </td>
              
              <td class="line_content"><span class="p">*</span> Start a <span class="p">[</span><span class="nv">nested workflow execution</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/step-functions/latest/dg/concepts-nested-workflows.html</span><span class="p">)</span> from a Task state. 
</td>
            </tr>
          
            
            <tr class="line_holder" id="L25">
              <td class="line-num" data-linenumber="25">
                <span class="linked-line" unselectable="on" data-linenumber="25"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L26">
              <td class="line-num" data-linenumber="26">
                <span class="linked-line" unselectable="on" data-linenumber="26"></span>
              </td>
              
              <td class="line_content">Solution can be deployed with the <span class="p">[</span><span class="nv">Cloud Formation Template</span><span class="p">](</span><span class="sx">cloud_formation_template/etl-orchestration-with-stepfunctions-and-redshift-data-api.yaml</span><span class="p">)</span> that creates the below resources: 
</td>
            </tr>
          
            
            <tr class="line_holder" id="L27">
              <td class="line-num" data-linenumber="27">
                <span class="linked-line" unselectable="on" data-linenumber="27"></span>
              </td>
              
              <td class="line_content"><span class="p">1.</span> Database objects in the Amazon Redshift cluster
</td>
            </tr>
          
            
            <tr class="line_holder" id="L28">
              <td class="line-num" data-linenumber="28">
                <span class="linked-line" unselectable="on" data-linenumber="28"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> Five Redshift tables - to be used by the ETL workflow 
</td>
            </tr>
          
            
            <tr class="line_holder" id="L29">
              <td class="line-num" data-linenumber="29">
                <span class="linked-line" unselectable="on" data-linenumber="29"></span>
              </td>
              
              <td class="line_content"><span class="p">		1.</span> customer
</td>
            </tr>
          
            
            <tr class="line_holder" id="L30">
              <td class="line-num" data-linenumber="30">
                <span class="linked-line" unselectable="on" data-linenumber="30"></span>
              </td>
              
              <td class="line_content"><span class="p">		2.</span> customer_address
</td>
            </tr>
          
            
            <tr class="line_holder" id="L31">
              <td class="line-num" data-linenumber="31">
                <span class="linked-line" unselectable="on" data-linenumber="31"></span>
              </td>
              
              <td class="line_content"><span class="p">		3.</span> date_dim
</td>
            </tr>
          
            
            <tr class="line_holder" id="L32">
              <td class="line-num" data-linenumber="32">
                <span class="linked-line" unselectable="on" data-linenumber="32"></span>
              </td>
              
              <td class="line_content"><span class="p">		4.</span> item
</td>
            </tr>
          
            
            <tr class="line_holder" id="L33">
              <td class="line-num" data-linenumber="33">
                <span class="linked-line" unselectable="on" data-linenumber="33"></span>
              </td>
              
              <td class="line_content"><span class="p">		5.</span> store_sales
</td>
            </tr>
          
            
            <tr class="line_holder" id="L34">
              <td class="line-num" data-linenumber="34">
                <span class="linked-line" unselectable="on" data-linenumber="34"></span>
              </td>
              
              <td class="line_content"><span class="p">2.</span> <span class="p">[</span><span class="nv">AWS IAM Role</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html</span><span class="p">)</span>, <span class="sb">`LambdaRedshiftBatchDataAPIRole`</span> for AWS Lambda to allow below permissions:
</td>
            </tr>
          
            
            <tr class="line_holder" id="L35">
              <td class="line-num" data-linenumber="35">
                <span class="linked-line" unselectable="on" data-linenumber="35"></span>
              </td>
              
              <td class="line_content"><span class="p">    *</span> Federate to the Amazon Redshift cluster through <span class="sb">`getClusterCredentials`</span> permission avoiding password credentials.
</td>
            </tr>
          
            
            <tr class="line_holder" id="L36">
              <td class="line-num" data-linenumber="36">
                <span class="linked-line" unselectable="on" data-linenumber="36"></span>
              </td>
              
              <td class="line_content"><span class="p">    *</span> Execute queries in Amazon Redshift cluster through Redshift Data API calls
</td>
            </tr>
          
            
            <tr class="line_holder" id="L37">
              <td class="line-num" data-linenumber="37">
                <span class="linked-line" unselectable="on" data-linenumber="37"></span>
              </td>
              
              <td class="line_content"><span class="p">    *</span> Logging with AWS CloudWatch for troubleshooting purpose
</td>
            </tr>
          
            
            <tr class="line_holder" id="L38">
              <td class="line-num" data-linenumber="38">
                <span class="linked-line" unselectable="on" data-linenumber="38"></span>
              </td>
              
              <td class="line_content"><span class="p">    *</span> List and retrieves objects from Amazon S3
</td>
            </tr>
          
            
            <tr class="line_holder" id="L39">
              <td class="line-num" data-linenumber="39">
                <span class="linked-line" unselectable="on" data-linenumber="39"></span>
              </td>
              
              <td class="line_content"><span class="p">3.</span> <span class="p">[</span><span class="nv">AWS IAM Role</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html</span><span class="p">)</span>, <span class="sb">`StateMachineExecutionRole`</span> for AWS Step Functions to allow below permissions:
</td>
            </tr>
          
            
            <tr class="line_holder" id="L40">
              <td class="line-num" data-linenumber="40">
                <span class="linked-line" unselectable="on" data-linenumber="40"></span>
              </td>
              
              <td class="line_content"><span class="p">    *</span> Execute the <span class="sb">`redshift_batch_data_api`</span> lambda function within the Step Function
</td>
            </tr>
          
            
            <tr class="line_holder" id="L41">
              <td class="line-num" data-linenumber="41">
                <span class="linked-line" unselectable="on" data-linenumber="41"></span>
              </td>
              
              <td class="line_content"><span class="p">4.</span> <span class="p">[</span><span class="nv">AWS Lambda function</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/lambda/latest/dg/welcome.html</span><span class="p">)</span>, <span class="sb">`redshift_batch_data_api`</span> is executed as soon as the Step Function is executed. The AWS Lambda function will execute SQL statements in Amazon Redshift leveraging the <span class="sb">`redshift-data`</span> client. Based on the input parameter <span class="sb">`action`</span> that is passed by the AWS Step Function, this lambda function can asynchronously execute Structured Query Language (SQL) statements in Amazon Redshift and thus avoid chances of timing-out in case of long running SQL statements. It uses <span class="p">[</span><span class="nv">Amazon Redshift Data API's</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html</span><span class="p">)</span> temporary credentials functionality, which allows it to communicate with Amazon Redshift using AWS Identity and Access Management (IAM) permission, without the need of any password-based authentication. With Data API, there is also no need to configure drivers and connections for your Amazon Redshift cluster, which is handled automatically.
</td>
            </tr>
          
            
            <tr class="line_holder" id="L42">
              <td class="line-num" data-linenumber="42">
                <span class="linked-line" unselectable="on" data-linenumber="42"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L43">
              <td class="line-num" data-linenumber="43">
                <span class="linked-line" unselectable="on" data-linenumber="43"></span>
              </td>
              
              <td class="line_content">   As there are multiple SQL statements that needs to be executed as a part of a single transaction to ensure data integrity, these SQL statements will be executed in a batch using the <span class="p">[</span><span class="nv">"batch-execute-statement" API.</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/redshift-data/latest/APIReference/API_BatchExecuteStatement.html</span><span class="p">)</span>
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
              
              <td class="line_content"><span class="p">5.</span> <span class="p">[</span><span class="nv">AWS Step Functions state machine</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/step-functions/latest/dg/welcome.html</span><span class="p">)</span>, <span class="sb">`RedshiftETLStepFunction`</span>, which contains the steps used to orchestrate AWS services and build serverless applications.
</td>
            </tr>
          
            
            <tr class="line_holder" id="L46">
              <td class="line-num" data-linenumber="46">
                <span class="linked-line" unselectable="on" data-linenumber="46"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L47">
              <td class="line-num" data-linenumber="47">
                <span class="linked-line" unselectable="on" data-linenumber="47"></span>
              </td>
              
              <td class="line_content"><span class="gh"># Goal of the Archictecture  </span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L48">
              <td class="line-num" data-linenumber="48">
                <span class="linked-line" unselectable="on" data-linenumber="48"></span>
              </td>
              
              <td class="line_content">1) Deploy Redshift Database Objects
</td>
            </tr>
          
            
            <tr class="line_holder" id="L49">
              <td class="line-num" data-linenumber="49">
                <span class="linked-line" unselectable="on" data-linenumber="49"></span>
              </td>
              
              <td class="line_content">2) Load a set of sample data 
</td>
            </tr>
          
            
            <tr class="line_holder" id="L50">
              <td class="line-num" data-linenumber="50">
                <span class="linked-line" unselectable="on" data-linenumber="50"></span>
              </td>
              
              <td class="line_content">3) Run the multi-step ETL process as per the defined job dependencies
</td>
            </tr>
          
            
            <tr class="line_holder" id="L51">
              <td class="line-num" data-linenumber="51">
                <span class="linked-line" unselectable="on" data-linenumber="51"></span>
              </td>
              
              <td class="line_content">4) Validate the data was processed successfully
</td>
            </tr>
          
            
            <tr class="line_holder" id="L52">
              <td class="line-num" data-linenumber="52">
                <span class="linked-line" unselectable="on" data-linenumber="52"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L53">
              <td class="line-num" data-linenumber="53">
                <span class="linked-line" unselectable="on" data-linenumber="53"></span>
              </td>
              
              <td class="line_content"><span class="gh"># Steps</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L54">
              <td class="line-num" data-linenumber="54">
                <span class="linked-line" unselectable="on" data-linenumber="54"></span>
              </td>
              
              <td class="line_content"><span class="p">1.</span> Once the <span class="p">[</span><span class="nv">Cloud Formation Template</span><span class="p">](</span><span class="sx">cloud_formation_template/etl-orchestration-with-stepfunctions-and-redshift-data-api.yaml</span><span class="p">)</span> is deployed, go to the "Resources" and click on the Physical ID column of the <span class="sb">`RedshiftETLStepFunction`</span> in order to navigate to the <span class="p">[</span><span class="nv">AWS Step Function</span><span class="p">](</span><span class="sx">https://aws.amazon.com/step-functions/</span><span class="p">)</span> console.
</td>
            </tr>
          
            
            <tr class="line_holder" id="L55">
              <td class="line-num" data-linenumber="55">
                <span class="linked-line" unselectable="on" data-linenumber="55"></span>
              </td>
              
              <td class="line_content"><span class="p">![</span><span class="nv">CloudFormation Resources</span><span class="p">](</span><span class="sx">images/cloudformation_resources.png</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L56">
              <td class="line-num" data-linenumber="56">
                <span class="linked-line" unselectable="on" data-linenumber="56"></span>
              </td>
              
              <td class="line_content"><span class="p">2.</span> Click the "Start execution" button using the default settings to execute the <span class="sb">`RedshiftETLStepFunction`</span> step function that allows you to visualize the execution of the ETL workflow in real time.
</td>
            </tr>
          
            
            <tr class="line_holder" id="L57">
              <td class="line-num" data-linenumber="57">
                <span class="linked-line" unselectable="on" data-linenumber="57"></span>
              </td>
              
              <td class="line_content"><span class="p">![</span><span class="nv">StepFunction Execution</span><span class="p">](</span><span class="sx">images/step_function_workflow_execution.png</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L58">
              <td class="line-num" data-linenumber="58">
                <span class="linked-line" unselectable="on" data-linenumber="58"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L59">
              <td class="line-num" data-linenumber="59">
                <span class="linked-line" unselectable="on" data-linenumber="59"></span>
              </td>
              
              <td class="line_content">Below steps outlines the workflow:
</td>
            </tr>
          
            
            <tr class="line_holder" id="L60">
              <td class="line-num" data-linenumber="60">
                <span class="linked-line" unselectable="on" data-linenumber="60"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L61">
              <td class="line-num" data-linenumber="61">
                <span class="linked-line" unselectable="on" data-linenumber="61"></span>
              </td>
              
              <td class="line_content"><span class="p">1.</span> <span class="sb">`setup_sales_data_pipeline`</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L62">
              <td class="line-num" data-linenumber="62">
                <span class="linked-line" unselectable="on" data-linenumber="62"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> Invokes the <span class="sb">`redshift_batch_data_api`</span> lambda function and sends a <span class="sb">`setup_sales_data_pipeline`</span> action
</td>
            </tr>
          
            
            <tr class="line_holder" id="L63">
              <td class="line-num" data-linenumber="63">
                <span class="linked-line" unselectable="on" data-linenumber="63"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> Retrieves the <span class="p">[</span><span class="nv">setup_sales_data_pipeline.sql</span><span class="p">](</span><span class="sx">scripts/setup_sales_data_pipeline.sql</span><span class="p">)</span> from S3 to get the SQL statements to be executed
</td>
            </tr>
          
            
            <tr class="line_holder" id="L64">
              <td class="line-num" data-linenumber="64">
                <span class="linked-line" unselectable="on" data-linenumber="64"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> Pass the SQL statements to the <span class="p">[</span><span class="nv">"batch-execute-statement" API</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/redshift-data/latest/APIReference/API_BatchExecuteStatement.html</span><span class="p">)</span> to run in the <span class="p">[</span><span class="nv">Amazon Redshift</span><span class="p">](</span><span class="sx">https://aws.amazon.com/redshift/</span><span class="p">)</span> cluster
</td>
            </tr>
          
            
            <tr class="line_holder" id="L65">
              <td class="line-num" data-linenumber="65">
                <span class="linked-line" unselectable="on" data-linenumber="65"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> Sends back the identifier of the SQL statement to the step function 			
</td>
            </tr>
          
            
            <tr class="line_holder" id="L66">
              <td class="line-num" data-linenumber="66">
                <span class="linked-line" unselectable="on" data-linenumber="66"></span>
              </td>
              
              <td class="line_content"><span class="p">2.</span> <span class="sb">`wait_on_setup_sales_data_pipeline`</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L67">
              <td class="line-num" data-linenumber="67">
                <span class="linked-line" unselectable="on" data-linenumber="67"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> Waits for at least 10 seconds
</td>
            </tr>
          
            
            <tr class="line_holder" id="L68">
              <td class="line-num" data-linenumber="68">
                <span class="linked-line" unselectable="on" data-linenumber="68"></span>
              </td>
              
              <td class="line_content"><span class="p">3.</span> <span class="sb">`setup_sales_data_pipeline_status_check`</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L69">
              <td class="line-num" data-linenumber="69">
                <span class="linked-line" unselectable="on" data-linenumber="69"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> Invokes the <span class="sb">`redshift_batch_data_api`</span> lambda function and sends a <span class="sb">`get_sql_status`</span> action to get the status of the API call
</td>
            </tr>
          
            
            <tr class="line_holder" id="L70">
              <td class="line-num" data-linenumber="70">
                <span class="linked-line" unselectable="on" data-linenumber="70"></span>
              </td>
              
              <td class="line_content"><span class="p">4.</span> <span class="sb">`is_setup_sales_data_pipeline_complete`</span> - routes the next step of the ETL workflow as per the following:
</td>
            </tr>
          
            
            <tr class="line_holder" id="L71">
              <td class="line-num" data-linenumber="71">
                <span class="linked-line" unselectable="on" data-linenumber="71"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> FINISHED - Execute the SQL statements to process the two dimension tables (customer_address and item) and one fact table (sales)
</td>
            </tr>
          
            
            <tr class="line_holder" id="L72">
              <td class="line-num" data-linenumber="72">
                <span class="linked-line" unselectable="on" data-linenumber="72"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> FAILED - Go to <span class="sb">`sales_data_pipeline_failure`</span> step and fail the ETL workflow
</td>
            </tr>
          
            
            <tr class="line_holder" id="L73">
              <td class="line-num" data-linenumber="73">
                <span class="linked-line" unselectable="on" data-linenumber="73"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> All other status - Go back to the <span class="sb">`wait_on_setup_sales_data_pipeline`</span> step to wait for the SQL statements to finish
</td>
            </tr>
          
            
            <tr class="line_holder" id="L74">
              <td class="line-num" data-linenumber="74">
                <span class="linked-line" unselectable="on" data-linenumber="74"></span>
              </td>
              
              <td class="line_content"><span class="p">	</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L75">
              <td class="line-num" data-linenumber="75">
                <span class="linked-line" unselectable="on" data-linenumber="75"></span>
              </td>
              
              <td class="line_content"><span class="p">5.</span> <span class="sb">`run_sales_data_pipeline`</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L76">
              <td class="line-num" data-linenumber="76">
                <span class="linked-line" unselectable="on" data-linenumber="76"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> Invokes the <span class="sb">`redshift_batch_data_api`</span> lambda function and sends a <span class="sb">`run_sales_data_pipeline`</span> action
</td>
            </tr>
          
            
            <tr class="line_holder" id="L77">
              <td class="line-num" data-linenumber="77">
                <span class="linked-line" unselectable="on" data-linenumber="77"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> Retrieves the <span class="p">[</span><span class="nv">run_sales_data_pipeline.sql</span><span class="p">](</span><span class="sx">scripts/run_sales_data_pipeline.sql</span><span class="p">)</span> from S3 to get the SQL statements to be executed
</td>
            </tr>
          
            
            <tr class="line_holder" id="L78">
              <td class="line-num" data-linenumber="78">
                <span class="linked-line" unselectable="on" data-linenumber="78"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> Pass the SQL statements to the <span class="p">[</span><span class="nv">"batch-execute-statement" API.</span><span class="p">](</span><span class="sx">https://docs.aws.amazon.com/redshift-data/latest/APIReference/API_BatchExecuteStatement.html</span><span class="p">)</span> to run in the <span class="p">[</span><span class="nv">Amazon Redshift</span><span class="p">](</span><span class="sx">https://aws.amazon.com/redshift/</span><span class="p">)</span> cluster
</td>
            </tr>
          
            
            <tr class="line_holder" id="L79">
              <td class="line-num" data-linenumber="79">
                <span class="linked-line" unselectable="on" data-linenumber="79"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> Sends back the identifier of the SQL statement to the step function 			
</td>
            </tr>
          
            
            <tr class="line_holder" id="L80">
              <td class="line-num" data-linenumber="80">
                <span class="linked-line" unselectable="on" data-linenumber="80"></span>
              </td>
              
              <td class="line_content"><span class="p">6.</span> <span class="sb">`wait_on_run_sales_data_pipeline`</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L81">
              <td class="line-num" data-linenumber="81">
                <span class="linked-line" unselectable="on" data-linenumber="81"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> Waits for at least 10 seconds
</td>
            </tr>
          
            
            <tr class="line_holder" id="L82">
              <td class="line-num" data-linenumber="82">
                <span class="linked-line" unselectable="on" data-linenumber="82"></span>
              </td>
              
              <td class="line_content"><span class="p">7.</span> <span class="sb">`run_sales_data_pipeline_status_check`</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L83">
              <td class="line-num" data-linenumber="83">
                <span class="linked-line" unselectable="on" data-linenumber="83"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> Invokes the <span class="sb">`redshift_batch_data_api`</span> lambda function and sends a <span class="sb">`get_sql_status`</span> action to get the status of the API call
</td>
            </tr>
          
            
            <tr class="line_holder" id="L84">
              <td class="line-num" data-linenumber="84">
                <span class="linked-line" unselectable="on" data-linenumber="84"></span>
              </td>
              
              <td class="line_content"><span class="p">8.</span> <span class="sb">`is_run_sales_data_pipeline_complete`</span> - routes the next step of the ETL workflow as per the following:
</td>
            </tr>
          
            
            <tr class="line_holder" id="L85">
              <td class="line-num" data-linenumber="85">
                <span class="linked-line" unselectable="on" data-linenumber="85"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> FINISHED - Go to <span class="sb">`sales_data_pipeline_success`</span> step and stop the ETL worklow
</td>
            </tr>
          
            
            <tr class="line_holder" id="L86">
              <td class="line-num" data-linenumber="86">
                <span class="linked-line" unselectable="on" data-linenumber="86"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> FAILED - Go to <span class="sb">`sales_data_pipeline_failure`</span> step and fail the ETL workflow
</td>
            </tr>
          
            
            <tr class="line_holder" id="L87">
              <td class="line-num" data-linenumber="87">
                <span class="linked-line" unselectable="on" data-linenumber="87"></span>
              </td>
              
              <td class="line_content"><span class="p">	*</span> All other status - Go back to the <span class="sb">`wait_on_run_sales_data_pipeline`</span> step to wait for the SQL statements to finish			
</td>
            </tr>
          
            
            <tr class="line_holder" id="L88">
              <td class="line-num" data-linenumber="88">
                <span class="linked-line" unselectable="on" data-linenumber="88"></span>
              </td>
              
              <td class="line_content">		
</td>
            </tr>
          
            
            <tr class="line_holder" id="L89">
              <td class="line-num" data-linenumber="89">
                <span class="linked-line" unselectable="on" data-linenumber="89"></span>
              </td>
              
              <td class="line_content"><span class="gs">**Note**</span>: The implementation of the ETL workflow is idempotent. If it fails, you can retry the job without any cleanup. For example, it recreates the <span class="sb">`stg_store_sales`</span> table each time, then deletes target table <span class="sb">`store_sales`</span> with the data for the particular refresh date each time.
</td>
            </tr>
          
            
            <tr class="line_holder" id="L90">
              <td class="line-num" data-linenumber="90">
                <span class="linked-line" unselectable="on" data-linenumber="90"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L91">
              <td class="line-num" data-linenumber="91">
                <span class="linked-line" unselectable="on" data-linenumber="91"></span>
              </td>
              
              <td class="line_content"><span class="gh"># Validation</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L92">
              <td class="line-num" data-linenumber="92">
                <span class="linked-line" unselectable="on" data-linenumber="92"></span>
              </td>
              
              <td class="line_content">The entire ETL workflow takes around 1 minute to run and you should see the following diagram when the ETL workflow execution completed successfully.
</td>
            </tr>
          
            
            <tr class="line_holder" id="L93">
              <td class="line-num" data-linenumber="93">
                <span class="linked-line" unselectable="on" data-linenumber="93"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L94">
              <td class="line-num" data-linenumber="94">
                <span class="linked-line" unselectable="on" data-linenumber="94"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L95">
              <td class="line-num" data-linenumber="95">
                <span class="linked-line" unselectable="on" data-linenumber="95"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L96">
              <td class="line-num" data-linenumber="96">
                <span class="linked-line" unselectable="on" data-linenumber="96"></span>
              </td>
              
              <td class="line_content"><span class="p">![</span><span class="nv">StepFunction WorkflowSuccess</span><span class="p">](</span><span class="sx">images/sales_data_pipeline_step_function_workflow.png</span><span class="p">)</span>
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
          data: [{"text":"This Commit's Parents","children":[{"text":"28a67ed6^1 (cc439589)","id":"/packages/Amazon-redshift-data-api-getting-started/blobs/cc439589df2c0d50b6965e6e41f6da2e80a64931/--/use-cases/etl-orchestration-with-lambda-and-step-functions/README.md"}]},{"text":"Official Branches","children":[{"text":"dev-general-readme","id":"/packages/Amazon-redshift-data-api-getting-started/blobs/heads/dev-general-readme/--/use-cases/etl-orchestration-with-lambda-and-step-functions/README.md"},{"text":"dev-java","id":"/packages/Amazon-redshift-data-api-getting-started/blobs/heads/dev-java/--/use-cases/etl-orchestration-with-lambda-and-step-functions/README.md"},{"text":"mainline (default)","id":"/packages/Amazon-redshift-data-api-getting-started/blobs/heads/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/README.md"}]}],
          createSearchChoice: function(term, data) {
            if ($(data).filter(function() { return this.text.localeCompare(term)===0; }).length===0) {
              // This code fires if the user enters a string and hits return (rather than selecting the item
              // from the dropdown.  This breaks when viewing commits (logs). Customize it accordingly.
              if ('/packages/Amazon-redshift-data-api-getting-started/blobs/'.match(/\/logs/)) {
                var id_string = '/packages/Amazon-redshift-data-api-getting-started/blobs//' + term;
                if ('use-cases/etl-orchestration-with-lambda-and-step-functions/README.md') {
                  id_string += '/--/use-cases/etl-orchestration-with-lambda-and-step-functions/README.md';
                }
                return {text:term, id: id_string};
              }
              return {text:term, id:'/packages/Amazon-redshift-data-api-getting-started/blobs/' + term + '/--/use-cases/etl-orchestration-with-lambda-and-step-functions/README.md'};
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
