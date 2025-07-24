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
<body class="password_resets user-page no-sidebar  ">
  <div id="wrap">
    <div class="l-mainWrapper" id="main">
      <header class="header">
        <div class="col-xs-12">
          <div class="text-centered">${msg("updatePasswordMessage")}</div>
        </div>
      </header>
      <div class="centent">
        <section class="edit-panel">
          <div class="col-sm-6 col-sm-offset-3">
            <form class="clearfix" id="edit_account" action="${url.loginAction}" accept-charset="UTF-8" method="post">
              <input type="text" id="username" name="username" value="${username}" autocomplete="username" readonly="readonly" style="display:none;"/>
              <input type="password" id="password" name="password" autocomplete="current-password" style="display:none;"/>
              <div class="form-group">${msg("passwordNew")}
                <input class="col-xs-12" type="password" name="password-new" id="account_password" aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>" />
              </div>
              <div class="form-group">${msg("passwordNewConfirm")}
                <input class="col-xs-12" type="password" name="password-confirm" id="account_password_confirmation"
                    autocomplete="new-password"
                    aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>" />
              </div>
              <#if messagesPerField.existsError('password')>
                <div class="form-group">
                    <span id="input-error-password" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                        ${kcSanitize(messagesPerField.get('password'))?no_esc}
                    </span>
                </div>
              <#elseif messagesPerField.existsError('password-confirm')>
                <div class="form-group">
                    <span id="input-error-password-confirm" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                        ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                    </span>
                </div>
              </#if>
              <input type="submit" name="commit" value="${msg("doUpdate")}" class="btn btn-blue col-xs-12" data-disable-with="${msg("doSubmit")}" />
            </form>
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
