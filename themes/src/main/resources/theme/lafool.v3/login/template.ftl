<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

<head>
    <meta charset="utf-8">
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1" name="viewport" />
    <meta name="robots" content="noindex, nofollow">
    <meta content="public/browserconfig.xml" name="msapplication-config" />

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <link rel="apple-touch-icon" type="image/x-icon" href="${url.resourcesPath}/img/apple-touch-icon.png" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
</head>

<body class="sessions -page no-sidebar">
  <div id="wrap">
    <div class="l-mainWrapper" id="main">
      <div class="p-login__header">
      </div>
      <div class="p-login__formArea">
        <#nested "form">
      </div>
      <footer style="position:relative">
        <div id="copy">&copy; lafool Inc.</div>
      </footer>
    </div>
  </div>
  <div id="loader-wrapper">
    <div id="loader"></div>
    <div class="loader-section sec-left"></div>
    <div class="loader-section sec-right"></div>
  </div>
</body>
</html>
</#macro>
