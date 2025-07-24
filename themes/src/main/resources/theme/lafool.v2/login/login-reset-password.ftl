<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible" />
    <meta content="user-scalable=no, initial-scale=1, maximum-scale=1" name="viewport" />
    <meta content="noindex,nofollow" name="robots" />
    <meta content="public/browserconfig.xml" name="msapplication-config" />
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />

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
<body class="passwords -page no-sidebar  ">
  <div id="wrap">
    <div class="l-mainWrapper" id="main">
      <header class="header">
        <div class="col-xs-12">
          <div class="text-centered">${msg("resetPasswordMessageJA0")}<br class="visible-xs" />${msg("resetPasswordMessageEN0")}</div>
        </div>
      </header>
      <div class="content js-devisePassword p-account">
        <section class="edit-panel">
          <div class="col-sm-6 col-sm-offset-3">
            <div class="tools-alert">
              ${msg("resetPasswordMessageJA1")}<br />
              ${msg("resetPasswordMessageJA2")}<br />
              <span>
                ${msg("resetPasswordMessageEN1")}<br />
                ${msg("resetPasswordMessageEN2")}
              </span>
            </div>
            <form class="clearfix js-passwordForm mt-10" id="new_account" action="${url.loginAction}" accept-charset="UTF-8" method="post">
              <div class="form-group">
                <div class="p-account__fieldError js-fieldError">${msg("emailFieldError")}</div>
                <input class="col-xs-12 js-passwordField" placeholder="${msg("loginEmailPlaceholder")}" type="text" name="username" id="account_email" autofocus value="${(auth.attemptedUsername!'')}" aria-invalid="<#if messagesPerField.existsError('username')>true</#if>" />
                <#if messagesPerField.existsError('username')>
                    <span id="input-error-username" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                ${kcSanitize(messagesPerField.get('username'))?no_esc}
                    </span>
                </#if>
              </div>
              <div class="btn btn-blue col-xs-12 my-15 js-passwordSubmit">${msg("doSubmit")}</div>
            </form>
          </div>
          <div class="col-sm-6 col-sm-offset-3 mt-30">
            <a class="btn btn-default" href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a>
          </div>
        </section>
      </div>
    </div>
  </div>
  <div id="loader-wrapper">
    <div id="loader"></div>
    <div class="loader-section sec-left"></div>
    <div class="loader-section sec-right"></div>
  </div>
</body>
</html>
