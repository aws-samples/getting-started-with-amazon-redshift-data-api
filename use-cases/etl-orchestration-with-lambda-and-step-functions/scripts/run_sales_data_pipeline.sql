<!DOCTYPE html>
<html>
<head>
<title>run_sales_data_pipeline.sql - Amazon-redshift-data-api-getting-started - Code Browser</title>
<meta content='width=device-width, initial-scale=1' name='viewport'>
<meta content='true' name='use-sentry'>
<meta content='418fd30f-892d-4598-a24b-1a8e408b00db' name='request-id'>
<meta name="csrf-param" content="authenticity_token" />
<meta name="csrf-token" content="y7zaFn/uDYtNUoakQR5jrYH63bnXB+Fx/VyUofbx+xH3VITnPtmANNtt7TSw5JeL8NhTOk8/gP0BljZzFdDNmA==" />
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
<li><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/scripts">scripts</a></li>
<li class='.active'>run_sales_data_pipeline.sql</li>


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
<input type="hidden" name="path" id="path" value="use-cases/etl-orchestration-with-lambda-and-step-functions/scripts/run_sales_data_pipeline.sql" />
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
<li><a href="/packages/Amazon-redshift-data-api-getting-started/metrics/a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4">Metrics</a></li>
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
<a title="Bipin Pandey (bipandey)" href="https://code.amazon.com/users/bipandey/activity">Bipin Pandey (bipandey)</a>
<li class='time'></li>
<span title='Committed on December 12, 2021 03:22:42 AM PST' class='relative-time hover_tooltip year_old'>3 months ago</span><span class='absolute-time hover_tooltip year_old'>2021-12-12 03:22:42 PST</span>
<li class='commit_message'>
<span class='refs'>
</span>
<a class='powertip commit black' data-commit-id='a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4' href='/packages/Amazon-redshift-data-api-getting-started/commits/a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4'>
commit bc625c3983e5009ede8a03e8be4559862ff09a8f Author: Bipin Pandey &lt;<a href="mailto:bipandey@amazon.com">bipandey@amazon.com</a>&gt; Date: 2021-12-10T02:37:25.000Z
</a>
</li>
<li><a class="mono powertip autoselect" data-powertip="a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4" data-commit-id="a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4" href="/packages/Amazon-redshift-data-api-getting-started/commits/a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4#use-cases/etl-orchestration-with-lambda-and-step-functions/scripts/run_sales_data_pipeline.sql">a6e7ec90</a></li>
<li>
<img alt="Pipelines logo" src="https://internal-cdn.amazon.com/pipelines.amazon.com/public/assets/favicon-a58010788e2014b36083d9b8766021876b1f1e219ed5496b9cc040a2712e4ea1.ico" />
<a href="https://pipelines.amazon.com/changes/PKG/Amazon-redshift-data-api-getting-started/mainline/GitFarm:a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4">Track in pipelines</a>
</li>
</ul>

<div class='swappable-with-brief-header'>
<div class='commit_header'>
<div class='portrait'>
<div style='display: flex'>
<div style='margin-left: 5px'>
<a href="https://code.amazon.com/users/bipandey/activity"><img class="" width="50" onerror="this.onerror=null; this.src=&#39;https://internal-cdn.amazon.com/code.amazon.com/pub/assets/cdn/default-user-b916c01d82910755cdba17db81688d35c994cf77a5907d721a6d93522961d007.gif&#39;" src="https://internal-cdn.amazon.com/badgephotos.amazon.com/phone-image.pl?uid=bipandey" /></a>
</div>
</div>
</div>
<div class='details'>
<div class='pull-right' id='track_pipeline_change' style='clear-right'>
<ul class='list-unstyled'>
<li>
<img src="https://pipelines.amazon.com/favicon.ico" />
<a href="https://pipelines.amazon.com/changes/PKG/Amazon-redshift-data-api-getting-started/mainline/GitFarm:a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4">Track in pipelines</a>
<span class='subtext'>(mainline)</span>
</li>
</ul>
</div>
<div class='download-diff pull-right' style='clear: right'>
<a href="/api/packages/Amazon-redshift-data-api-getting-started/diff/a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4">Download Diff</a>
</div>
<div class='pull-right' id='browse_source' style='clear: right'>
<a href="/packages/Amazon-redshift-data-api-getting-started/trees/a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4">Browse source at this commit</a>
</div>
<div class='pull-right' id='child_link' style='clear: right'>
<a href="/packages/Amazon-redshift-data-api-getting-started/commits/a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4.child">view child commit</a>
</div>
<ul class='list-unstyled pull-right' style='clear: right; margin-bottom: 0px'>
<li><a href="/packages/Amazon-redshift-data-api-getting-started/commits/80d94d6de753891e698d5c908262a93d38268dbc">view parent (80d94d6d)</a></li></ul>
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
<form action="/create_relation" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="&#x2713;" /><input type="hidden" name="authenticity_token" value="zTq3dnsK9uPIaeJo8BagcK4CiPF+syGB+N47aHzJPV7x0umHOj17XF5WifgB7FRW3yAGcuaLQA0EFJm6n+gL1w==" />
Relate this commit to url:
<input name='relation' type='text'>
<input type="hidden" name="package_id" id="package_id" value="Amazon-redshift-data-api-getting-started" />
<input type="hidden" name="commit_id" id="commit_id" value="a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4" />
<input type="submit" name="commit" value="Save" class="btn btn-default" data-disable-with="Save" />
</form>

</div>
</div>
<div class='author'>
<div class='author-line' style='font-size: 120%'>
<span class='name'><a title="Bipin Pandey (bipandey)" href="https://code.amazon.com/users/bipandey/activity">Bipin Pandey (bipandey)</a></span>
<span class='sha1'>
(<a class='powertip autoselect' data-powertip='a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4' href='/packages/Amazon-redshift-data-api-getting-started/commits/a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4'>a6e7ec90</a>)
</span>
</div>
<div id='extra-commit-and-branch-info'>
authored: <span title='December 12, 2021 03:22:42 AM PST' class='relative-time hover_tooltip year_old'>3 months ago</span><span class='absolute-time hover_tooltip year_old'>2021-12-12 03:22:42 PST</span>, committed: <span title='December 12, 2021 03:22:42 AM PST' class='relative-time hover_tooltip year_old'>3 months ago</span><span class='absolute-time hover_tooltip year_old'>2021-12-12 03:22:42 PST</span>
<div class='summaries'>
<div class='summary'>
Pushed to
<span class='autoselect branch powertip ref' data-powertip='mainline'>mainline</span>
by bipandey <span title='December 12, 2021 03:22:53 AM PST' class='relative-time hover_tooltip year_old'>3 months ago</span><span class='absolute-time hover_tooltip year_old'>2021-12-12 03:22:53 PST</span> as part of <a class='powertip autoselect' data-powertip='ebadf2944b1c78cb3bf09b8e43a2b4fd1f29497a' href='/packages/Amazon-redshift-data-api-getting-started/commits/ebadf2944b1c78cb3bf09b8e43a2b4fd1f29497a'>ebadf294</a>
</div>
</div>


</div>
<p class='top-buffer'>
<span class='subject'>
<a href="/packages/Amazon-redshift-data-api-getting-started/commits/a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4">commit bc625c3983e5009ede8a03e8be4559862ff09a8f Author: Bipin Pandey &lt;<a href="mailto:bipandey@amazon.com">bipandey@amazon.com</a>&gt; Date: 2021-12-10T02:37:25.000Z</a>
</span>
</p>
</div>
<pre>Adding ETL Workflow using only step function with Redshift Data API&#x000A;&#x000A;commit b5c3c4e7decbea8f18f0b865176dfce410cef327&#x000A;Author: Bipin Pandey &lt;<a href="mailto:bipandey@amazon.com">bipandey@amazon.com</a>&gt;&#x000A;Date: 2021-12-10T00:59:01.000Z&#x000A;&#x000A;Adding ETL Workflow using only step function with Redshift Data API</pre>
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
mime_type: text/plain; charset=us-ascii
-->
<div class='file_header'>
<div class='path_breadcrumbs'>
<div class='path_breadcrumbs'>
<span class='path_breadcrumb'><a href="/packages/Amazon-redshift-data-api-getting-started">Amazon-redshift-data-api-getting-started</a></span>/<span class='path_breadcrumb'><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/">mainline</a></span>/<span class='path_breadcrumb'><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/use-cases">use-cases</a></span>/<span class='path_breadcrumb'><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions">etl-orchestration-with-lambda-and-step-functions</a></span>/<span class='path_breadcrumb'><a href="/packages/Amazon-redshift-data-api-getting-started/trees/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/scripts">scripts</a></span>/<span class='path_breadcrumb'>run_sales_data_pipeline.sql</span>
</div>

</div>
<div class='hidden-print' id='file_actions'>
<ul class='button_group'>
<li>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/blobs/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/scripts/run_sales_data_pipeline.sql?raw=1">Raw</a>
</li>
<li>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/blobs/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/scripts/run_sales_data_pipeline.sql?download=1">Download</a>
</li>
<li>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/logs/mainline?path=use-cases%2Fetl-orchestration-with-lambda-and-step-functions%2Fscripts%2Frun_sales_data_pipeline.sql">History</a>
</li>
<li>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/blobs/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/scripts/run_sales_data_pipeline.sql/edit_file_online">Edit</a>
</li>
<li class='permalink'>
<a class="minibutton" href="/packages/Amazon-redshift-data-api-getting-started/blobs/a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4/--/use-cases/etl-orchestration-with-lambda-and-step-functions/scripts/run_sales_data_pipeline.sql">Permalink</a>
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
              
              <td class="line_content"><span class="k">begin</span> <span class="n">transaction</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L2">
              <td class="line-num" data-linenumber="2">
                <span class="linked-line" unselectable="on" data-linenumber="2"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Create a staging table to hold the input data. Staging table is created with BACKUP NO option for faster inserts and also data temporary */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L3">
              <td class="line-num" data-linenumber="3">
                <span class="linked-line" unselectable="on" data-linenumber="3"></span>
              </td>
              
              <td class="line_content"><span class="k">drop</span> <span class="k">table</span> <span class="n">if</span> <span class="k">exists</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_customer_address</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L4">
              <td class="line-num" data-linenumber="4">
                <span class="linked-line" unselectable="on" data-linenumber="4"></span>
              </td>
              
              <td class="line_content"><span class="k">create</span> <span class="k">table</span> <span class="n">if</span> <span class="k">not</span> <span class="k">exists</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_customer_address</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L5">
              <td class="line-num" data-linenumber="5">
                <span class="linked-line" unselectable="on" data-linenumber="5"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="n">ca_address_id</span>    <span class="nb">varchar</span><span class="p">(</span><span class="mi">16</span><span class="p">)</span>  <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L6">
              <td class="line-num" data-linenumber="6">
                <span class="linked-line" unselectable="on" data-linenumber="6"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ca_state</span>         <span class="nb">varchar</span><span class="p">(</span><span class="mi">2</span><span class="p">)</span>   <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L7">
              <td class="line-num" data-linenumber="7">
                <span class="linked-line" unselectable="on" data-linenumber="7"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ca_zip</span>           <span class="nb">varchar</span><span class="p">(</span><span class="mi">10</span><span class="p">)</span>  <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L8">
              <td class="line-num" data-linenumber="8">
                <span class="linked-line" unselectable="on" data-linenumber="8"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ca_country</span>       <span class="nb">varchar</span><span class="p">(</span><span class="mi">20</span><span class="p">)</span>  <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L9">
              <td class="line-num" data-linenumber="9">
                <span class="linked-line" unselectable="on" data-linenumber="9"></span>
              </td>
              
              <td class="line_content"><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L10">
              <td class="line-num" data-linenumber="10">
                <span class="linked-line" unselectable="on" data-linenumber="10"></span>
              </td>
              
              <td class="line_content"><span class="n">backup</span> <span class="k">no</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L11">
              <td class="line-num" data-linenumber="11">
                <span class="linked-line" unselectable="on" data-linenumber="11"></span>
              </td>
              
              <td class="line_content"><span class="n">diststyle</span> <span class="n">even</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L12">
              <td class="line-num" data-linenumber="12">
                <span class="linked-line" unselectable="on" data-linenumber="12"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Ingest data from source */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L13">
              <td class="line-num" data-linenumber="13">
                <span class="linked-line" unselectable="on" data-linenumber="13"></span>
              </td>
              
              <td class="line_content"><span class="k">insert</span> <span class="k">into</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_customer_address</span> <span class="p">(</span><span class="n">ca_address_id</span><span class="p">,</span><span class="n">ca_state</span><span class="p">,</span><span class="n">ca_zip</span><span class="p">,</span><span class="n">ca_country</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L14">
              <td class="line-num" data-linenumber="14">
                <span class="linked-line" unselectable="on" data-linenumber="14"></span>
              </td>
              
              <td class="line_content"><span class="k">values</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L15">
              <td class="line-num" data-linenumber="15">
                <span class="linked-line" unselectable="on" data-linenumber="15"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'AAAAAAAACFBBAAAA'</span><span class="p">,</span><span class="s1">'NE'</span><span class="p">,</span><span class="s1">''</span><span class="p">,</span><span class="s1">'United States'</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L16">
              <td class="line-num" data-linenumber="16">
                <span class="linked-line" unselectable="on" data-linenumber="16"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'AAAAAAAAGAEFAAAA'</span><span class="p">,</span><span class="s1">'NE'</span><span class="p">,</span><span class="s1">'61749'</span><span class="p">,</span><span class="s1">'United States'</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L17">
              <td class="line-num" data-linenumber="17">
                <span class="linked-line" unselectable="on" data-linenumber="17"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'AAAAAAAAPJKKAAAA'</span><span class="p">,</span><span class="s1">'OK'</span><span class="p">,</span><span class="s1">''</span><span class="p">,</span><span class="s1">'United States'</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L18">
              <td class="line-num" data-linenumber="18">
                <span class="linked-line" unselectable="on" data-linenumber="18"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'AAAAAAAAMIHGAAAA'</span><span class="p">,</span><span class="s1">'AL'</span><span class="p">,</span><span class="s1">''</span><span class="p">,</span><span class="s1">'United States'</span><span class="p">);</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L19">
              <td class="line-num" data-linenumber="19">
                <span class="linked-line" unselectable="on" data-linenumber="19"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Perform UPDATE for existing data with refreshed attribute values */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L20">
              <td class="line-num" data-linenumber="20">
                <span class="linked-line" unselectable="on" data-linenumber="20"></span>
              </td>
              
              <td class="line_content"><span class="k">update</span> <span class="k">public</span><span class="p">.</span><span class="n">customer_address</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L21">
              <td class="line-num" data-linenumber="21">
                <span class="linked-line" unselectable="on" data-linenumber="21"></span>
              </td>
              
              <td class="line_content">   <span class="k">set</span> <span class="n">ca_state</span> <span class="o">=</span> <span class="n">stg_customer_address</span><span class="p">.</span><span class="n">ca_state</span><span class="p">,</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L22">
              <td class="line-num" data-linenumber="22">
                <span class="linked-line" unselectable="on" data-linenumber="22"></span>
              </td>
              
              <td class="line_content">       <span class="n">ca_zip</span> <span class="o">=</span> <span class="n">stg_customer_address</span><span class="p">.</span><span class="n">ca_zip</span><span class="p">,</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L23">
              <td class="line-num" data-linenumber="23">
                <span class="linked-line" unselectable="on" data-linenumber="23"></span>
              </td>
              
              <td class="line_content">       <span class="n">ca_country</span> <span class="o">=</span> <span class="n">stg_customer_address</span><span class="p">.</span><span class="n">ca_country</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L24">
              <td class="line-num" data-linenumber="24">
                <span class="linked-line" unselectable="on" data-linenumber="24"></span>
              </td>
              
              <td class="line_content">  <span class="k">from</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_customer_address</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L25">
              <td class="line-num" data-linenumber="25">
                <span class="linked-line" unselectable="on" data-linenumber="25"></span>
              </td>
              
              <td class="line_content"> <span class="k">where</span> <span class="n">customer_address</span><span class="p">.</span><span class="n">ca_address_id</span> <span class="o">=</span> <span class="n">stg_customer_address</span><span class="p">.</span><span class="n">ca_address_id</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L26">
              <td class="line-num" data-linenumber="26">
                <span class="linked-line" unselectable="on" data-linenumber="26"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Perform insert for new rows  */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L27">
              <td class="line-num" data-linenumber="27">
                <span class="linked-line" unselectable="on" data-linenumber="27"></span>
              </td>
              
              <td class="line_content"><span class="k">insert</span> <span class="k">into</span> <span class="k">public</span><span class="p">.</span><span class="n">customer_address</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L28">
              <td class="line-num" data-linenumber="28">
                <span class="linked-line" unselectable="on" data-linenumber="28"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="n">ca_address_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L29">
              <td class="line-num" data-linenumber="29">
                <span class="linked-line" unselectable="on" data-linenumber="29"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ca_address_id</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L30">
              <td class="line-num" data-linenumber="30">
                <span class="linked-line" unselectable="on" data-linenumber="30"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ca_state</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L31">
              <td class="line-num" data-linenumber="31">
                <span class="linked-line" unselectable="on" data-linenumber="31"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ca_zip</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L32">
              <td class="line-num" data-linenumber="32">
                <span class="linked-line" unselectable="on" data-linenumber="32"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ca_country</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L33">
              <td class="line-num" data-linenumber="33">
                <span class="linked-line" unselectable="on" data-linenumber="33"></span>
              </td>
              
              <td class="line_content"><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L34">
              <td class="line-num" data-linenumber="34">
                <span class="linked-line" unselectable="on" data-linenumber="34"></span>
              </td>
              
              <td class="line_content"><span class="k">with</span> <span class="n">max_customer_address_sk</span> <span class="k">as</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L35">
              <td class="line-num" data-linenumber="35">
                <span class="linked-line" unselectable="on" data-linenumber="35"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="k">select</span> <span class="k">max</span><span class="p">(</span><span class="n">ca_address_sk</span><span class="p">)</span> <span class="n">max_ca_address_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L36">
              <td class="line-num" data-linenumber="36">
                <span class="linked-line" unselectable="on" data-linenumber="36"></span>
              </td>
              
              <td class="line_content"><span class="k">from</span> <span class="k">public</span><span class="p">.</span><span class="n">customer_address</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L37">
              <td class="line-num" data-linenumber="37">
                <span class="linked-line" unselectable="on" data-linenumber="37"></span>
              </td>
              
              <td class="line_content"><span class="k">select</span> <span class="n">row_number</span><span class="p">()</span> <span class="n">over</span> <span class="p">(</span><span class="k">order</span> <span class="k">by</span> <span class="n">stg_customer_address</span><span class="p">.</span><span class="n">ca_address_id</span><span class="p">)</span> <span class="o">+</span> <span class="n">max_customer_address_sk</span><span class="p">.</span><span class="n">max_ca_address_sk</span> <span class="k">as</span> <span class="n">ca_address_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L38">
              <td class="line-num" data-linenumber="38">
                <span class="linked-line" unselectable="on" data-linenumber="38"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">stg_customer_address</span><span class="p">.</span><span class="n">ca_address_id</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L39">
              <td class="line-num" data-linenumber="39">
                <span class="linked-line" unselectable="on" data-linenumber="39"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">stg_customer_address</span><span class="p">.</span><span class="n">ca_state</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L40">
              <td class="line-num" data-linenumber="40">
                <span class="linked-line" unselectable="on" data-linenumber="40"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">stg_customer_address</span><span class="p">.</span><span class="n">ca_zip</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L41">
              <td class="line-num" data-linenumber="41">
                <span class="linked-line" unselectable="on" data-linenumber="41"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">stg_customer_address</span><span class="p">.</span><span class="n">ca_country</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L42">
              <td class="line-num" data-linenumber="42">
                <span class="linked-line" unselectable="on" data-linenumber="42"></span>
              </td>
              
              <td class="line_content"><span class="k">from</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_customer_address</span><span class="p">,</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L43">
              <td class="line-num" data-linenumber="43">
                <span class="linked-line" unselectable="on" data-linenumber="43"></span>
              </td>
              
              <td class="line_content"><span class="n">max_customer_address_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L44">
              <td class="line-num" data-linenumber="44">
                <span class="linked-line" unselectable="on" data-linenumber="44"></span>
              </td>
              
              <td class="line_content"><span class="k">where</span> <span class="n">stg_customer_address</span><span class="p">.</span><span class="n">ca_address_id</span> <span class="k">not</span> <span class="k">in</span> <span class="p">(</span><span class="k">select</span> <span class="n">customer_address</span><span class="p">.</span><span class="n">ca_address_id</span> <span class="k">from</span> <span class="k">public</span><span class="p">.</span><span class="n">customer_address</span><span class="p">);</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L45">
              <td class="line-num" data-linenumber="45">
                <span class="linked-line" unselectable="on" data-linenumber="45"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Commit and End transaction */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L46">
              <td class="line-num" data-linenumber="46">
                <span class="linked-line" unselectable="on" data-linenumber="46"></span>
              </td>
              
              <td class="line_content"><span class="k">commit</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L47">
              <td class="line-num" data-linenumber="47">
                <span class="linked-line" unselectable="on" data-linenumber="47"></span>
              </td>
              
              <td class="line_content"><span class="k">end</span> <span class="n">transaction</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L48">
              <td class="line-num" data-linenumber="48">
                <span class="linked-line" unselectable="on" data-linenumber="48"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L49">
              <td class="line-num" data-linenumber="49">
                <span class="linked-line" unselectable="on" data-linenumber="49"></span>
              </td>
              
              <td class="line_content"><span class="k">begin</span> <span class="n">transaction</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L50">
              <td class="line-num" data-linenumber="50">
                <span class="linked-line" unselectable="on" data-linenumber="50"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Create a staging table to hold the input data. Staging table is created with BACKUP NO option for faster inserts and also data temporary */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L51">
              <td class="line-num" data-linenumber="51">
                <span class="linked-line" unselectable="on" data-linenumber="51"></span>
              </td>
              
              <td class="line_content"><span class="k">drop</span> <span class="k">table</span> <span class="n">if</span> <span class="k">exists</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_item</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L52">
              <td class="line-num" data-linenumber="52">
                <span class="linked-line" unselectable="on" data-linenumber="52"></span>
              </td>
              
              <td class="line_content"><span class="k">create</span> <span class="k">table</span> <span class="n">if</span> <span class="k">not</span> <span class="k">exists</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_item</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L53">
              <td class="line-num" data-linenumber="53">
                <span class="linked-line" unselectable="on" data-linenumber="53"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="n">i_item_id</span>        <span class="nb">varchar</span><span class="p">(</span><span class="mi">16</span><span class="p">)</span> <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L54">
              <td class="line-num" data-linenumber="54">
                <span class="linked-line" unselectable="on" data-linenumber="54"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">i_rec_start_date</span> <span class="nb">date</span> <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L55">
              <td class="line-num" data-linenumber="55">
                <span class="linked-line" unselectable="on" data-linenumber="55"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">i_rec_end_date</span>   <span class="nb">date</span> <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L56">
              <td class="line-num" data-linenumber="56">
                <span class="linked-line" unselectable="on" data-linenumber="56"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">i_current_price</span>  <span class="nb">numeric</span><span class="p">(</span><span class="mi">7</span><span class="p">,</span><span class="mi">2</span><span class="p">)</span> <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L57">
              <td class="line-num" data-linenumber="57">
                <span class="linked-line" unselectable="on" data-linenumber="57"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">i_category</span>       <span class="nb">varchar</span><span class="p">(</span><span class="mi">50</span><span class="p">)</span> <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L58">
              <td class="line-num" data-linenumber="58">
                <span class="linked-line" unselectable="on" data-linenumber="58"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">i_product_name</span>   <span class="nb">varchar</span><span class="p">(</span><span class="mi">50</span><span class="p">)</span> <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L59">
              <td class="line-num" data-linenumber="59">
                <span class="linked-line" unselectable="on" data-linenumber="59"></span>
              </td>
              
              <td class="line_content"><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L60">
              <td class="line-num" data-linenumber="60">
                <span class="linked-line" unselectable="on" data-linenumber="60"></span>
              </td>
              
              <td class="line_content"><span class="n">backup</span> <span class="k">no</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L61">
              <td class="line-num" data-linenumber="61">
                <span class="linked-line" unselectable="on" data-linenumber="61"></span>
              </td>
              
              <td class="line_content"><span class="n">diststyle</span> <span class="n">even</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L62">
              <td class="line-num" data-linenumber="62">
                <span class="linked-line" unselectable="on" data-linenumber="62"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Ingest data from source */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L63">
              <td class="line-num" data-linenumber="63">
                <span class="linked-line" unselectable="on" data-linenumber="63"></span>
              </td>
              
              <td class="line_content"><span class="k">insert</span> <span class="k">into</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_item</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L64">
              <td class="line-num" data-linenumber="64">
                <span class="linked-line" unselectable="on" data-linenumber="64"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="n">i_item_id</span><span class="p">,</span><span class="n">i_rec_start_date</span><span class="p">,</span><span class="n">i_rec_end_date</span><span class="p">,</span><span class="n">i_current_price</span><span class="p">,</span><span class="n">i_category</span><span class="p">,</span><span class="n">i_product_name</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L65">
              <td class="line-num" data-linenumber="65">
                <span class="linked-line" unselectable="on" data-linenumber="65"></span>
              </td>
              
              <td class="line_content"><span class="k">values</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L66">
              <td class="line-num" data-linenumber="66">
                <span class="linked-line" unselectable="on" data-linenumber="66"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'AAAAAAAAIFNAAAAA'</span><span class="p">,</span><span class="s1">'2021-04-27'</span><span class="p">,</span><span class="k">NULL</span><span class="p">,</span><span class="mi">15</span><span class="p">.</span><span class="mi">10</span><span class="p">,</span><span class="s1">'Electronics'</span><span class="p">,</span><span class="s1">'ationoughtesepri'</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L67">
              <td class="line-num" data-linenumber="67">
                <span class="linked-line" unselectable="on" data-linenumber="67"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'AAAAAAAAOIFCAAAA'</span><span class="p">,</span><span class="s1">'2021-04-27'</span><span class="p">,</span><span class="k">NULL</span><span class="p">,</span><span class="mi">9</span><span class="p">.</span><span class="mi">96</span><span class="p">,</span><span class="s1">'Home'</span><span class="p">,</span><span class="s1">'antioughtcallyn st'</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L68">
              <td class="line-num" data-linenumber="68">
                <span class="linked-line" unselectable="on" data-linenumber="68"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'AAAAAAAAMGOAAAAA'</span><span class="p">,</span><span class="s1">'2021-06-26'</span><span class="p">,</span><span class="k">NULL</span><span class="p">,</span><span class="mi">2</span><span class="p">.</span><span class="mi">25</span><span class="p">,</span><span class="s1">'Men'</span><span class="p">,</span><span class="s1">'prin stcallypri'</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L69">
              <td class="line-num" data-linenumber="69">
                <span class="linked-line" unselectable="on" data-linenumber="69"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'AAAAAAAAIHAEAAAA'</span><span class="p">,</span><span class="s1">'2021-03-14'</span><span class="p">,</span><span class="k">NULL</span><span class="p">,</span><span class="mi">3</span><span class="p">.</span><span class="mi">85</span><span class="p">,</span><span class="s1">'Home'</span><span class="p">,</span><span class="s1">'callybaranticallyought'</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L70">
              <td class="line-num" data-linenumber="70">
                <span class="linked-line" unselectable="on" data-linenumber="70"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'AAAAAAAAMCOAAAAA'</span><span class="p">,</span><span class="s1">'2021-03-14'</span><span class="p">,</span><span class="k">NULL</span><span class="p">,</span><span class="mi">2</span><span class="p">.</span><span class="mi">95</span><span class="p">,</span><span class="s1">'Electronics'</span><span class="p">,</span><span class="s1">'barprically'</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L71">
              <td class="line-num" data-linenumber="71">
                <span class="linked-line" unselectable="on" data-linenumber="71"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'AAAAAAAAILOBAAAA'</span><span class="p">,</span><span class="s1">'2021-03-14'</span><span class="p">,</span><span class="k">NULL</span><span class="p">,</span><span class="mi">12</span><span class="p">.</span><span class="mi">60</span><span class="p">,</span><span class="s1">'Jewelry'</span><span class="p">,</span><span class="s1">'callycallyeingation'</span><span class="p">);</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L72">
              <td class="line-num" data-linenumber="72">
                <span class="linked-line" unselectable="on" data-linenumber="72"></span>
              </td>
              
              <td class="line_content"><span class="cm">/************************************************************************************************************************</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L73">
              <td class="line-num" data-linenumber="73">
                <span class="linked-line" unselectable="on" data-linenumber="73"></span>
              </td>
              
              <td class="line_content"><span class="cm">** Type 2 is maintained for i_current_price column.</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L74">
              <td class="line-num" data-linenumber="74">
                <span class="linked-line" unselectable="on" data-linenumber="74"></span>
              </td>
              
              <td class="line_content"><span class="cm">** Update all attributes for the item when the price is not changed</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L75">
              <td class="line-num" data-linenumber="75">
                <span class="linked-line" unselectable="on" data-linenumber="75"></span>
              </td>
              
              <td class="line_content"><span class="cm">** Sunset existing active item record with current i_rec_end_date and insert a new record when the price does not match</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L76">
              <td class="line-num" data-linenumber="76">
                <span class="linked-line" unselectable="on" data-linenumber="76"></span>
              </td>
              
              <td class="line_content"><span class="cm">*************************************************************************************************************************/</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L77">
              <td class="line-num" data-linenumber="77">
                <span class="linked-line" unselectable="on" data-linenumber="77"></span>
              </td>
              
              <td class="line_content"><span class="k">update</span> <span class="k">public</span><span class="p">.</span><span class="n">item</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L78">
              <td class="line-num" data-linenumber="78">
                <span class="linked-line" unselectable="on" data-linenumber="78"></span>
              </td>
              
              <td class="line_content">   <span class="k">set</span> <span class="n">i_category</span> <span class="o">=</span> <span class="n">stg_item</span><span class="p">.</span><span class="n">i_category</span><span class="p">,</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L79">
              <td class="line-num" data-linenumber="79">
                <span class="linked-line" unselectable="on" data-linenumber="79"></span>
              </td>
              
              <td class="line_content">       <span class="n">i_product_name</span> <span class="o">=</span> <span class="n">stg_item</span><span class="p">.</span><span class="n">i_product_name</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L80">
              <td class="line-num" data-linenumber="80">
                <span class="linked-line" unselectable="on" data-linenumber="80"></span>
              </td>
              
              <td class="line_content">  <span class="k">from</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_item</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L81">
              <td class="line-num" data-linenumber="81">
                <span class="linked-line" unselectable="on" data-linenumber="81"></span>
              </td>
              
              <td class="line_content"> <span class="k">where</span> <span class="n">item</span><span class="p">.</span><span class="n">i_item_id</span> <span class="o">=</span> <span class="n">stg_item</span><span class="p">.</span><span class="n">i_item_id</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L82">
              <td class="line-num" data-linenumber="82">
                <span class="linked-line" unselectable="on" data-linenumber="82"></span>
              </td>
              
              <td class="line_content">   <span class="k">and</span> <span class="n">item</span><span class="p">.</span><span class="n">i_rec_end_date</span> <span class="k">is</span> <span class="k">null</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L83">
              <td class="line-num" data-linenumber="83">
                <span class="linked-line" unselectable="on" data-linenumber="83"></span>
              </td>
              
              <td class="line_content">   <span class="k">and</span> <span class="n">item</span><span class="p">.</span><span class="n">i_current_price</span> <span class="o">=</span> <span class="n">stg_item</span><span class="p">.</span><span class="n">i_current_price</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L84">
              <td class="line-num" data-linenumber="84">
                <span class="linked-line" unselectable="on" data-linenumber="84"></span>
              </td>
              
              <td class="line_content"><span class="k">insert</span> <span class="k">into</span> <span class="k">public</span><span class="p">.</span><span class="n">item</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L85">
              <td class="line-num" data-linenumber="85">
                <span class="linked-line" unselectable="on" data-linenumber="85"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="n">i_item_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L86">
              <td class="line-num" data-linenumber="86">
                <span class="linked-line" unselectable="on" data-linenumber="86"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">i_item_id</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L87">
              <td class="line-num" data-linenumber="87">
                <span class="linked-line" unselectable="on" data-linenumber="87"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">i_rec_start_date</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L88">
              <td class="line-num" data-linenumber="88">
                <span class="linked-line" unselectable="on" data-linenumber="88"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">i_rec_end_date</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L89">
              <td class="line-num" data-linenumber="89">
                <span class="linked-line" unselectable="on" data-linenumber="89"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">i_current_price</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L90">
              <td class="line-num" data-linenumber="90">
                <span class="linked-line" unselectable="on" data-linenumber="90"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">i_category</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L91">
              <td class="line-num" data-linenumber="91">
                <span class="linked-line" unselectable="on" data-linenumber="91"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">i_product_name</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L92">
              <td class="line-num" data-linenumber="92">
                <span class="linked-line" unselectable="on" data-linenumber="92"></span>
              </td>
              
              <td class="line_content"><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L93">
              <td class="line-num" data-linenumber="93">
                <span class="linked-line" unselectable="on" data-linenumber="93"></span>
              </td>
              
              <td class="line_content"><span class="k">with</span> <span class="n">max_item_sk</span> <span class="k">as</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L94">
              <td class="line-num" data-linenumber="94">
                <span class="linked-line" unselectable="on" data-linenumber="94"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="k">select</span> <span class="k">max</span><span class="p">(</span><span class="n">i_item_sk</span><span class="p">)</span> <span class="n">max_item_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L95">
              <td class="line-num" data-linenumber="95">
                <span class="linked-line" unselectable="on" data-linenumber="95"></span>
              </td>
              
              <td class="line_content">   <span class="k">from</span> <span class="k">public</span><span class="p">.</span><span class="n">item</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L96">
              <td class="line-num" data-linenumber="96">
                <span class="linked-line" unselectable="on" data-linenumber="96"></span>
              </td>
              
              <td class="line_content"><span class="k">select</span> <span class="n">row_number</span><span class="p">()</span> <span class="n">over</span> <span class="p">(</span><span class="k">order</span> <span class="k">by</span> <span class="n">stg_item</span><span class="p">.</span><span class="n">i_item_id</span><span class="p">)</span> <span class="o">+</span> <span class="n">max_item_sk</span> <span class="k">as</span> <span class="n">i_item_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L97">
              <td class="line-num" data-linenumber="97">
                <span class="linked-line" unselectable="on" data-linenumber="97"></span>
              </td>
              
              <td class="line_content">      <span class="p">,</span><span class="n">stg_item</span><span class="p">.</span><span class="n">i_item_id</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L98">
              <td class="line-num" data-linenumber="98">
                <span class="linked-line" unselectable="on" data-linenumber="98"></span>
              </td>
              
              <td class="line_content">      <span class="p">,</span><span class="n">trunc</span><span class="p">(</span><span class="n">sysdate</span><span class="p">)</span> <span class="k">as</span> <span class="n">i_rec_start_date</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L99">
              <td class="line-num" data-linenumber="99">
                <span class="linked-line" unselectable="on" data-linenumber="99"></span>
              </td>
              
              <td class="line_content">      <span class="p">,</span><span class="k">null</span> <span class="k">as</span> <span class="n">i_rec_end_date</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L100">
              <td class="line-num" data-linenumber="100">
                <span class="linked-line" unselectable="on" data-linenumber="100"></span>
              </td>
              
              <td class="line_content">      <span class="p">,</span><span class="n">stg_item</span><span class="p">.</span><span class="n">i_current_price</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L101">
              <td class="line-num" data-linenumber="101">
                <span class="linked-line" unselectable="on" data-linenumber="101"></span>
              </td>
              
              <td class="line_content">      <span class="p">,</span><span class="n">stg_item</span><span class="p">.</span><span class="n">i_category</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L102">
              <td class="line-num" data-linenumber="102">
                <span class="linked-line" unselectable="on" data-linenumber="102"></span>
              </td>
              
              <td class="line_content">      <span class="p">,</span><span class="n">stg_item</span><span class="p">.</span><span class="n">i_product_name</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L103">
              <td class="line-num" data-linenumber="103">
                <span class="linked-line" unselectable="on" data-linenumber="103"></span>
              </td>
              
              <td class="line_content">  <span class="k">from</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_item</span><span class="p">,</span> <span class="k">public</span><span class="p">.</span><span class="n">item</span><span class="p">,</span> <span class="n">max_item_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L104">
              <td class="line-num" data-linenumber="104">
                <span class="linked-line" unselectable="on" data-linenumber="104"></span>
              </td>
              
              <td class="line_content"> <span class="k">where</span> <span class="n">item</span><span class="p">.</span><span class="n">i_item_id</span> <span class="o">=</span> <span class="n">stg_item</span><span class="p">.</span><span class="n">i_item_id</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L105">
              <td class="line-num" data-linenumber="105">
                <span class="linked-line" unselectable="on" data-linenumber="105"></span>
              </td>
              
              <td class="line_content">   <span class="k">and</span> <span class="n">item</span><span class="p">.</span><span class="n">i_rec_end_date</span> <span class="k">is</span> <span class="k">null</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L106">
              <td class="line-num" data-linenumber="106">
                <span class="linked-line" unselectable="on" data-linenumber="106"></span>
              </td>
              
              <td class="line_content">   <span class="k">and</span> <span class="n">item</span><span class="p">.</span><span class="n">i_current_price</span> <span class="o">&lt;&gt;</span> <span class="n">stg_item</span><span class="p">.</span><span class="n">i_current_price</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L107">
              <td class="line-num" data-linenumber="107">
                <span class="linked-line" unselectable="on" data-linenumber="107"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Sunset penultimate records that were inserted as type 2 */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L108">
              <td class="line-num" data-linenumber="108">
                <span class="linked-line" unselectable="on" data-linenumber="108"></span>
              </td>
              
              <td class="line_content"><span class="k">update</span> <span class="k">public</span><span class="p">.</span><span class="n">item</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L109">
              <td class="line-num" data-linenumber="109">
                <span class="linked-line" unselectable="on" data-linenumber="109"></span>
              </td>
              
              <td class="line_content">   <span class="k">set</span> <span class="n">i_rec_end_date</span> <span class="o">=</span> <span class="n">trunc</span><span class="p">(</span><span class="n">sysdate</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L110">
              <td class="line-num" data-linenumber="110">
                <span class="linked-line" unselectable="on" data-linenumber="110"></span>
              </td>
              
              <td class="line_content">  <span class="k">from</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_item</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L111">
              <td class="line-num" data-linenumber="111">
                <span class="linked-line" unselectable="on" data-linenumber="111"></span>
              </td>
              
              <td class="line_content"> <span class="k">where</span> <span class="n">item</span><span class="p">.</span><span class="n">i_item_id</span> <span class="o">=</span> <span class="n">stg_item</span><span class="p">.</span><span class="n">i_item_id</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L112">
              <td class="line-num" data-linenumber="112">
                <span class="linked-line" unselectable="on" data-linenumber="112"></span>
              </td>
              
              <td class="line_content">   <span class="k">and</span> <span class="n">item</span><span class="p">.</span><span class="n">i_rec_end_date</span> <span class="k">is</span> <span class="k">null</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L113">
              <td class="line-num" data-linenumber="113">
                <span class="linked-line" unselectable="on" data-linenumber="113"></span>
              </td>
              
              <td class="line_content">   <span class="k">and</span> <span class="n">item</span><span class="p">.</span><span class="n">i_current_price</span> <span class="o">&lt;&gt;</span> <span class="n">stg_item</span><span class="p">.</span><span class="n">i_current_price</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L114">
              <td class="line-num" data-linenumber="114">
                <span class="linked-line" unselectable="on" data-linenumber="114"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Commit and End transaction */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L115">
              <td class="line-num" data-linenumber="115">
                <span class="linked-line" unselectable="on" data-linenumber="115"></span>
              </td>
              
              <td class="line_content"><span class="k">commit</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L116">
              <td class="line-num" data-linenumber="116">
                <span class="linked-line" unselectable="on" data-linenumber="116"></span>
              </td>
              
              <td class="line_content"><span class="k">end</span> <span class="n">transaction</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L117">
              <td class="line-num" data-linenumber="117">
                <span class="linked-line" unselectable="on" data-linenumber="117"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L118">
              <td class="line-num" data-linenumber="118">
                <span class="linked-line" unselectable="on" data-linenumber="118"></span>
              </td>
              
              <td class="line_content"><span class="k">begin</span> <span class="n">transaction</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L119">
              <td class="line-num" data-linenumber="119">
                <span class="linked-line" unselectable="on" data-linenumber="119"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Create a stg_store_sales staging table */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L120">
              <td class="line-num" data-linenumber="120">
                <span class="linked-line" unselectable="on" data-linenumber="120"></span>
              </td>
              
              <td class="line_content"><span class="k">drop</span> <span class="k">table</span> <span class="n">if</span> <span class="k">exists</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_store_sales</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L121">
              <td class="line-num" data-linenumber="121">
                <span class="linked-line" unselectable="on" data-linenumber="121"></span>
              </td>
              
              <td class="line_content"><span class="k">create</span> <span class="k">table</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_store_sales</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L122">
              <td class="line-num" data-linenumber="122">
                <span class="linked-line" unselectable="on" data-linenumber="122"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="n">sold_date</span>             <span class="nb">date</span> <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L123">
              <td class="line-num" data-linenumber="123">
                <span class="linked-line" unselectable="on" data-linenumber="123"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">i_item_id</span>             <span class="nb">varchar</span><span class="p">(</span><span class="mi">16</span><span class="p">)</span> <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L124">
              <td class="line-num" data-linenumber="124">
                <span class="linked-line" unselectable="on" data-linenumber="124"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">c_customer_id</span>         <span class="nb">varchar</span><span class="p">(</span><span class="mi">16</span><span class="p">)</span> <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L125">
              <td class="line-num" data-linenumber="125">
                <span class="linked-line" unselectable="on" data-linenumber="125"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ca_address_id</span>         <span class="nb">varchar</span><span class="p">(</span><span class="mi">16</span><span class="p">)</span> <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L126">
              <td class="line-num" data-linenumber="126">
                <span class="linked-line" unselectable="on" data-linenumber="126"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ss_ticket_number</span>      <span class="nb">integer</span> <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L127">
              <td class="line-num" data-linenumber="127">
                <span class="linked-line" unselectable="on" data-linenumber="127"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ss_quantity</span>           <span class="nb">integer</span> <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L128">
              <td class="line-num" data-linenumber="128">
                <span class="linked-line" unselectable="on" data-linenumber="128"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ss_net_paid</span>           <span class="nb">numeric</span><span class="p">(</span><span class="mi">7</span><span class="p">,</span><span class="mi">2</span><span class="p">)</span> <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L129">
              <td class="line-num" data-linenumber="129">
                <span class="linked-line" unselectable="on" data-linenumber="129"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ss_net_profit</span>         <span class="nb">numeric</span><span class="p">(</span><span class="mi">7</span><span class="p">,</span><span class="mi">2</span><span class="p">)</span> <span class="n">encode</span> <span class="n">zstd</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L130">
              <td class="line-num" data-linenumber="130">
                <span class="linked-line" unselectable="on" data-linenumber="130"></span>
              </td>
              
              <td class="line_content"><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L131">
              <td class="line-num" data-linenumber="131">
                <span class="linked-line" unselectable="on" data-linenumber="131"></span>
              </td>
              
              <td class="line_content"><span class="n">backup</span> <span class="k">no</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L132">
              <td class="line-num" data-linenumber="132">
                <span class="linked-line" unselectable="on" data-linenumber="132"></span>
              </td>
              
              <td class="line_content"><span class="n">diststyle</span> <span class="n">even</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L133">
              <td class="line-num" data-linenumber="133">
                <span class="linked-line" unselectable="on" data-linenumber="133"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Ingest data from source */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L134">
              <td class="line-num" data-linenumber="134">
                <span class="linked-line" unselectable="on" data-linenumber="134"></span>
              </td>
              
              <td class="line_content"><span class="k">insert</span> <span class="k">into</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_store_sales</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L135">
              <td class="line-num" data-linenumber="135">
                <span class="linked-line" unselectable="on" data-linenumber="135"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="n">sold_date</span><span class="p">,</span><span class="n">i_item_id</span><span class="p">,</span><span class="n">c_customer_id</span><span class="p">,</span><span class="n">ca_address_id</span><span class="p">,</span><span class="n">ss_ticket_number</span><span class="p">,</span><span class="n">ss_quantity</span><span class="p">,</span><span class="n">ss_net_paid</span><span class="p">,</span><span class="n">ss_net_profit</span><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L136">
              <td class="line-num" data-linenumber="136">
                <span class="linked-line" unselectable="on" data-linenumber="136"></span>
              </td>
              
              <td class="line_content"><span class="k">values</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L137">
              <td class="line-num" data-linenumber="137">
                <span class="linked-line" unselectable="on" data-linenumber="137"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'2021-06-26'</span><span class="p">,</span><span class="s1">'AAAAAAAAIFNAAAAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAOHNBAAAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAGBOFNIAA'</span><span class="p">,</span><span class="mi">1403191</span><span class="p">,</span><span class="mi">13</span><span class="p">,</span><span class="mi">5046</span><span class="p">.</span><span class="mi">37</span><span class="p">,</span><span class="mi">150</span><span class="p">.</span><span class="mi">97</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L138">
              <td class="line-num" data-linenumber="138">
                <span class="linked-line" unselectable="on" data-linenumber="138"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'2021-06-26'</span><span class="p">,</span><span class="s1">'AAAAAAAAIFNAAAAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAOHNBAAAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAGBOFNIAA'</span><span class="p">,</span><span class="mi">1403191</span><span class="p">,</span><span class="mi">13</span><span class="p">,</span><span class="mi">2103</span><span class="p">.</span><span class="mi">72</span><span class="p">,</span><span class="o">-</span><span class="mi">124</span><span class="p">.</span><span class="mi">08</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L139">
              <td class="line-num" data-linenumber="139">
                <span class="linked-line" unselectable="on" data-linenumber="139"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'2021-06-26'</span><span class="p">,</span><span class="s1">'AAAAAAAAILOBAAAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAOHNBAAAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAGBOFNIAA'</span><span class="p">,</span><span class="mi">1403191</span><span class="p">,</span><span class="mi">13</span><span class="p">,</span><span class="mi">959</span><span class="p">.</span><span class="mi">10</span><span class="p">,</span><span class="o">-</span><span class="mi">1304</span><span class="p">.</span><span class="mi">70</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L140">
              <td class="line-num" data-linenumber="140">
                <span class="linked-line" unselectable="on" data-linenumber="140"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'2021-06-26'</span><span class="p">,</span><span class="s1">'AAAAAAAAILOBAAAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAHNAJAAAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAIAPCFNAA'</span><span class="p">,</span><span class="mi">1403191</span><span class="p">,</span><span class="mi">13</span><span class="p">,</span><span class="mi">962</span><span class="p">.</span><span class="mi">65</span><span class="p">,</span><span class="o">-</span><span class="mi">475</span><span class="p">.</span><span class="mi">80</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L141">
              <td class="line-num" data-linenumber="141">
                <span class="linked-line" unselectable="on" data-linenumber="141"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'2021-06-26'</span><span class="p">,</span><span class="s1">'AAAAAAAAMCOAAAAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAHNAJAAAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAIAPCFNAA'</span><span class="p">,</span><span class="mi">1201746</span><span class="p">,</span><span class="mi">17</span><span class="p">,</span><span class="mi">111</span><span class="p">.</span><span class="mi">60</span><span class="p">,</span><span class="o">-</span><span class="mi">241</span><span class="p">.</span><span class="mi">65</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L142">
              <td class="line-num" data-linenumber="142">
                <span class="linked-line" unselectable="on" data-linenumber="142"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'2021-06-26'</span><span class="p">,</span><span class="s1">'AAAAAAAAMCOAAAAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAHNAJAAAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAIAPCFNAA'</span><span class="p">,</span><span class="mi">1201746</span><span class="p">,</span><span class="mi">17</span><span class="p">,</span><span class="mi">4013</span><span class="p">.</span><span class="mi">02</span><span class="p">,</span><span class="o">-</span><span class="mi">1111</span><span class="p">.</span><span class="mi">48</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L143">
              <td class="line-num" data-linenumber="143">
                <span class="linked-line" unselectable="on" data-linenumber="143"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'2021-06-26'</span><span class="p">,</span><span class="s1">'AAAAAAAAMCOAAAAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAMJCLACAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAMIFKEHAA'</span><span class="p">,</span><span class="mi">1201746</span><span class="p">,</span><span class="mi">17</span><span class="p">,</span><span class="mi">2689</span><span class="p">.</span><span class="mi">12</span><span class="p">,</span><span class="o">-</span><span class="mi">5572</span><span class="p">.</span><span class="mi">28</span><span class="p">),</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L144">
              <td class="line-num" data-linenumber="144">
                <span class="linked-line" unselectable="on" data-linenumber="144"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="s1">'2021-06-26'</span><span class="p">,</span><span class="s1">'AAAAAAAAMGOAAAAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAMJCLACAA'</span><span class="p">,</span><span class="s1">'AAAAAAAAMIFKEHAA'</span><span class="p">,</span><span class="mi">193971</span><span class="p">,</span><span class="mi">18</span><span class="p">,</span><span class="mi">1876</span><span class="p">.</span><span class="mi">89</span><span class="p">,</span><span class="o">-</span><span class="mi">556</span><span class="p">.</span><span class="mi">35</span><span class="p">);</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L145">
              <td class="line-num" data-linenumber="145">
                <span class="linked-line" unselectable="on" data-linenumber="145"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Delete any rows from target store_sales for the input date for idempotency */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L146">
              <td class="line-num" data-linenumber="146">
                <span class="linked-line" unselectable="on" data-linenumber="146"></span>
              </td>
              
              <td class="line_content"><span class="k">delete</span> <span class="k">from</span> <span class="k">public</span><span class="p">.</span><span class="n">store_sales</span> <span class="k">where</span> <span class="n">ss_sold_date_sk</span> <span class="k">in</span> <span class="p">(</span><span class="k">select</span> <span class="n">d_date_sk</span> <span class="k">from</span> <span class="k">public</span><span class="p">.</span><span class="n">date_dim</span> <span class="k">where</span> <span class="n">d_date</span><span class="o">=</span><span class="s1">'{job_run_date}'</span><span class="p">);</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L147">
              <td class="line-num" data-linenumber="147">
                <span class="linked-line" unselectable="on" data-linenumber="147"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Insert data from staging table to the target table */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L148">
              <td class="line-num" data-linenumber="148">
                <span class="linked-line" unselectable="on" data-linenumber="148"></span>
              </td>
              
              <td class="line_content"><span class="k">insert</span> <span class="k">into</span> <span class="k">public</span><span class="p">.</span><span class="n">store_sales</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L149">
              <td class="line-num" data-linenumber="149">
                <span class="linked-line" unselectable="on" data-linenumber="149"></span>
              </td>
              
              <td class="line_content"><span class="p">(</span><span class="n">ss_sold_date_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L150">
              <td class="line-num" data-linenumber="150">
                <span class="linked-line" unselectable="on" data-linenumber="150"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ss_item_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L151">
              <td class="line-num" data-linenumber="151">
                <span class="linked-line" unselectable="on" data-linenumber="151"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ss_customer_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L152">
              <td class="line-num" data-linenumber="152">
                <span class="linked-line" unselectable="on" data-linenumber="152"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ss_addr_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L153">
              <td class="line-num" data-linenumber="153">
                <span class="linked-line" unselectable="on" data-linenumber="153"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ss_ticket_number</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L154">
              <td class="line-num" data-linenumber="154">
                <span class="linked-line" unselectable="on" data-linenumber="154"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ss_quantity</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L155">
              <td class="line-num" data-linenumber="155">
                <span class="linked-line" unselectable="on" data-linenumber="155"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ss_net_paid</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L156">
              <td class="line-num" data-linenumber="156">
                <span class="linked-line" unselectable="on" data-linenumber="156"></span>
              </td>
              
              <td class="line_content"><span class="p">,</span><span class="n">ss_net_profit</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L157">
              <td class="line-num" data-linenumber="157">
                <span class="linked-line" unselectable="on" data-linenumber="157"></span>
              </td>
              
              <td class="line_content"><span class="p">)</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L158">
              <td class="line-num" data-linenumber="158">
                <span class="linked-line" unselectable="on" data-linenumber="158"></span>
              </td>
              
              <td class="line_content"><span class="k">select</span> <span class="n">date_dim</span><span class="p">.</span><span class="n">d_date_sk</span> <span class="n">ss_sold_date_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L159">
              <td class="line-num" data-linenumber="159">
                <span class="linked-line" unselectable="on" data-linenumber="159"></span>
              </td>
              
              <td class="line_content">      <span class="p">,</span><span class="n">item</span><span class="p">.</span><span class="n">i_item_sk</span> <span class="n">ss_item_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L160">
              <td class="line-num" data-linenumber="160">
                <span class="linked-line" unselectable="on" data-linenumber="160"></span>
              </td>
              
              <td class="line_content">      <span class="p">,</span><span class="n">customer</span><span class="p">.</span><span class="n">c_customer_sk</span> <span class="n">ss_customer_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L161">
              <td class="line-num" data-linenumber="161">
                <span class="linked-line" unselectable="on" data-linenumber="161"></span>
              </td>
              
              <td class="line_content">      <span class="p">,</span><span class="n">customer_address</span><span class="p">.</span><span class="n">ca_address_sk</span> <span class="n">ss_addr_sk</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L162">
              <td class="line-num" data-linenumber="162">
                <span class="linked-line" unselectable="on" data-linenumber="162"></span>
              </td>
              
              <td class="line_content">      <span class="p">,</span><span class="n">ss_ticket_number</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L163">
              <td class="line-num" data-linenumber="163">
                <span class="linked-line" unselectable="on" data-linenumber="163"></span>
              </td>
              
              <td class="line_content">      <span class="p">,</span><span class="n">ss_quantity</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L164">
              <td class="line-num" data-linenumber="164">
                <span class="linked-line" unselectable="on" data-linenumber="164"></span>
              </td>
              
              <td class="line_content">      <span class="p">,</span><span class="n">ss_net_paid</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L165">
              <td class="line-num" data-linenumber="165">
                <span class="linked-line" unselectable="on" data-linenumber="165"></span>
              </td>
              
              <td class="line_content">      <span class="p">,</span><span class="n">ss_net_profit</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L166">
              <td class="line-num" data-linenumber="166">
                <span class="linked-line" unselectable="on" data-linenumber="166"></span>
              </td>
              
              <td class="line_content">  <span class="k">from</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_store_sales</span> <span class="k">as</span> <span class="n">store_sales</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L167">
              <td class="line-num" data-linenumber="167">
                <span class="linked-line" unselectable="on" data-linenumber="167"></span>
              </td>
              
              <td class="line_content">  <span class="k">inner</span> <span class="k">join</span> <span class="k">public</span><span class="p">.</span><span class="n">date_dim</span> <span class="k">on</span> <span class="n">store_sales</span><span class="p">.</span><span class="n">sold_date</span> <span class="o">=</span> <span class="n">date_dim</span><span class="p">.</span><span class="n">d_date</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L168">
              <td class="line-num" data-linenumber="168">
                <span class="linked-line" unselectable="on" data-linenumber="168"></span>
              </td>
              
              <td class="line_content">  <span class="k">left</span> <span class="k">join</span> <span class="k">public</span><span class="p">.</span><span class="n">item</span> <span class="k">on</span> <span class="n">store_sales</span><span class="p">.</span><span class="n">i_item_id</span> <span class="o">=</span> <span class="n">item</span><span class="p">.</span><span class="n">i_item_id</span> <span class="k">and</span> <span class="n">item</span><span class="p">.</span><span class="n">i_rec_end_date</span> <span class="k">is</span> <span class="k">null</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L169">
              <td class="line-num" data-linenumber="169">
                <span class="linked-line" unselectable="on" data-linenumber="169"></span>
              </td>
              
              <td class="line_content">  <span class="k">left</span> <span class="k">join</span> <span class="k">public</span><span class="p">.</span><span class="n">customer</span> <span class="k">on</span> <span class="n">store_sales</span><span class="p">.</span><span class="n">c_customer_id</span> <span class="o">=</span> <span class="n">customer</span><span class="p">.</span><span class="n">c_customer_id</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L170">
              <td class="line-num" data-linenumber="170">
                <span class="linked-line" unselectable="on" data-linenumber="170"></span>
              </td>
              
              <td class="line_content">  <span class="k">left</span> <span class="k">join</span> <span class="k">public</span><span class="p">.</span><span class="n">customer_address</span> <span class="k">on</span> <span class="n">store_sales</span><span class="p">.</span><span class="n">ca_address_id</span> <span class="o">=</span> <span class="n">customer_address</span><span class="p">.</span><span class="n">ca_address_id</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L171">
              <td class="line-num" data-linenumber="171">
                <span class="linked-line" unselectable="on" data-linenumber="171"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Drop staging table */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L172">
              <td class="line-num" data-linenumber="172">
                <span class="linked-line" unselectable="on" data-linenumber="172"></span>
              </td>
              
              <td class="line_content"><span class="k">drop</span> <span class="k">table</span> <span class="n">if</span> <span class="k">exists</span> <span class="k">public</span><span class="p">.</span><span class="n">stg_store_sales</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L173">
              <td class="line-num" data-linenumber="173">
                <span class="linked-line" unselectable="on" data-linenumber="173"></span>
              </td>
              
              <td class="line_content"><span class="cm">/* Commit and End transaction */</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L174">
              <td class="line-num" data-linenumber="174">
                <span class="linked-line" unselectable="on" data-linenumber="174"></span>
              </td>
              
              <td class="line_content"><span class="k">commit</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L175">
              <td class="line-num" data-linenumber="175">
                <span class="linked-line" unselectable="on" data-linenumber="175"></span>
              </td>
              
              <td class="line_content"><span class="k">end</span> <span class="n">transaction</span><span class="p">;</span>
</td>
            </tr>
          
            
            <tr class="line_holder" id="L176">
              <td class="line-num" data-linenumber="176">
                <span class="linked-line" unselectable="on" data-linenumber="176"></span>
              </td>
              
              <td class="line_content">
</td>
            </tr>
          
            
            <tr class="line_holder" id="L177">
              <td class="line-num" data-linenumber="177">
                <span class="linked-line" unselectable="on" data-linenumber="177"></span>
              </td>
              
              <td class="line_content"><span class="k">select</span> <span class="mi">1</span><span class="o">/</span><span class="k">count</span><span class="p">(</span><span class="mi">1</span><span class="p">)</span> <span class="k">from</span> <span class="k">public</span><span class="p">.</span><span class="n">store_sales</span> <span class="k">where</span> <span class="n">ss_sold_date_sk</span> <span class="k">in</span> <span class="p">(</span><span class="k">select</span> <span class="n">d_date_sk</span> <span class="k">from</span> <span class="k">public</span><span class="p">.</span><span class="n">date_dim</span> <span class="k">where</span> <span class="n">d_date</span><span class="o">=</span><span class="s1">'{job_run_date}'</span><span class="p">);</span>
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
          data: [{"text":"This Commit's Parents","children":[{"text":"a6e7ec90^1 (80d94d6d)","id":"/packages/Amazon-redshift-data-api-getting-started/blobs/80d94d6de753891e698d5c908262a93d38268dbc/--/use-cases/etl-orchestration-with-lambda-and-step-functions/scripts/run_sales_data_pipeline.sql"}]},{"text":"Official Branches","children":[{"text":"dev-general-readme","id":"/packages/Amazon-redshift-data-api-getting-started/blobs/heads/dev-general-readme/--/use-cases/etl-orchestration-with-lambda-and-step-functions/scripts/run_sales_data_pipeline.sql"},{"text":"dev-java","id":"/packages/Amazon-redshift-data-api-getting-started/blobs/heads/dev-java/--/use-cases/etl-orchestration-with-lambda-and-step-functions/scripts/run_sales_data_pipeline.sql"},{"text":"mainline (default)","id":"/packages/Amazon-redshift-data-api-getting-started/blobs/heads/mainline/--/use-cases/etl-orchestration-with-lambda-and-step-functions/scripts/run_sales_data_pipeline.sql"}]}],
          createSearchChoice: function(term, data) {
            if ($(data).filter(function() { return this.text.localeCompare(term)===0; }).length===0) {
              // This code fires if the user enters a string and hits return (rather than selecting the item
              // from the dropdown.  This breaks when viewing commits (logs). Customize it accordingly.
              if ('/packages/Amazon-redshift-data-api-getting-started/blobs/'.match(/\/logs/)) {
                var id_string = '/packages/Amazon-redshift-data-api-getting-started/blobs//' + term;
                if ('use-cases/etl-orchestration-with-lambda-and-step-functions/scripts/run_sales_data_pipeline.sql') {
                  id_string += '/--/use-cases/etl-orchestration-with-lambda-and-step-functions/scripts/run_sales_data_pipeline.sql';
                }
                return {text:term, id: id_string};
              }
              return {text:term, id:'/packages/Amazon-redshift-data-api-getting-started/blobs/' + term + '/--/use-cases/etl-orchestration-with-lambda-and-step-functions/scripts/run_sales_data_pipeline.sql'};
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
  
    relatedItems = new Codac.RelatedItemsModel('Amazon-redshift-data-api-getting-started', 'a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4', 'mainline', '');
  
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
        sha1: 'a6e7ec90e95ea7a4ab121ed9a984a468b53e08a4',
        path: 'use-cases/etl-orchestration-with-lambda-and-step-functions/scripts/run_sales_data_pipeline.sql',
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
