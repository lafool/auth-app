<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "form">
    <div class="brand">
      <img alt="ラフール" src="${url.resourcesPath}/img/logo.svg">
    </div>
    <#if realm.password>
        <form id="new_account" class="new_account" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
            <input tabindex="1" autofocus="autofocus" autocomplete="email"
                       class="${properties.kcInputClass!} col-xs-12 login-input form-control mb-10"
                       placeholder="${msg("loginUsernamePlaceholder")}" data-default="" inputmode="email"
                       type="text" name="username" id="username" value="${(login.username!'')}"
                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />

            <input tabindex="2" autocomplete="current-password" class="${properties.kcInputClass!} col-xs-12 login-input form-control"
                        placeholder="${msg("loginPasswordPlaceholder")}" data-default="" type="password" name="password"
                        id="password" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />

            <#if messagesPerField.existsError('username','password')>
                <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                </span>
            </#if>

            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
            <input tabindex="4" class="btn btn-blue col-xs-12"
                        name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>

            <div id="kc-form-options">
                <#if realm.rememberMe && !usernameEditDisabled??>
                    <div class="checkbox">
                        <label>
                            <#if login.rememberMe??>
                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                            <#else>
                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                            </#if>
                        </label>
                    </div>
                </#if>
            </div>
            <div class="${properties.kcFormOptionsWrapperClass!}">
                <#if realm.resetPasswordAllowed>
                    <p class="forget-link text-center">
                        <a tabindex="5" href="https://app.lafool.jp/accounts/password/new">
                            ${msg("doForgotPassword")}<br>
                            <span>${msg("doForgotPasswordSpan")}</span>
                        </a>
                    </p>
                </#if>
            </div>
        </form>
    </#if>

    <div class="p-login__messageArea">
      <p class="p-login__messageTitle">InternetExprolerご利用のお客様へ</p>
      <p class="p-login__messageItem">Microsoft社のInternet Explorerのサポート終了（2022年6月16日）に伴い、ラフールサーベイは2022年からInternet Explorerを動作保証対象外としております。詳しくは<a class="p-login__emailLink" target="_blank" rel="noopener noreferrer" href="https://survey.lafool.jp/support/sys_info/171-2/">ヘルプページ</a>をご覧ください。</p>
    </div>
    <div class="p-login__appLinkArea">
      <div class="p-login__appAppleLink">
        <a href="https://apps.apple.com/jp/app/lafool/id1342462230?mt=8" style="display:inline-block;overflow:hidden;background:url(https://linkmaker.itunes.apple.com/ja-jp/badge-lrg.svg?releaseDate=2018-03-12&kind=iossoftware&bubble=ios_apps) no-repeat;width:135px;height:40px;margin-top:10px;" target="_blank" rel="noopener noreferrer"></a>
      </div>
      <div class="p-login__appGoogleLink">
        <a href='https://play.google.com/store/apps/details?id=jp.lafool.lafoolapp&hl=ja&pcampaignid=pcampaignidMKT-Other-global-all-co-prtnr-py-PartBadge-Mar2515-1' target="_blank" rel="noopener noreferrer">
          <img alt='Google Play で手に入れよう' src='https://play.google.com/intl/ja/badges/static/images/badges/ja_badge_web_generic.png' style='width:100%;'/>
        </a>
      </div>
    </div>
    <p class="text-center" id="browser_message"></p>

    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
