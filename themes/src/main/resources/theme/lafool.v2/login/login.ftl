<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "form">
    <p class="p-login__formArea--text">１つのアカウント情報で複数の契約サービスにログインできます</p>
    <p class="p-login__formArea--description" style="text-align:center">ご契約されていないサービスの料金は発生しません<br>採用適性検査「テキカク」の導入をご検討の方は<br class="sp_show"><a href="https://survey.lafool.jp/tekikaku-contact/" target="_blank">お問い合わせ</a>ください</p>
    <div class="p-login__formAreaInner">
    <ul class="p-login__formArea--logo">
        <li class="p-login__formArea--logo_survey">
            <img alt="ラフールサーベイ" src="${url.resourcesPath}/img/logo_survey_mono.svg">
        </li>
        <li class="p-login__formArea--logo_tekikaku">
            <img alt="テキカク" src="${url.resourcesPath}/img/logo_tekikaku_mono.svg">
        </li>
    </ul>
    <#if realm.password>
        <div class="p-login__formArea--form">
        <form id="new_account" class="new_account" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
            <input tabindex="1" autofocus="autofocus" autocomplete="email"
                       class="${properties.kcInputClass!} login-input form-control mb-10"
                       placeholder="${msg("loginUsernamePlaceholder")}" data-default="" inputmode="email"
                       type="text" name="username" id="username" value="${(login.username!'')}"
                       aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />

            <input tabindex="2" autocomplete="current-password" class="${properties.kcInputClass!} login-input form-control"
                        placeholder="${msg("loginPasswordPlaceholder")}" data-default="" type="password" name="password"
                        id="password" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />

            <#if messagesPerField.existsError('username','password')>
                <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                        ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                </span>
            </#if>

            <div class="${properties.kcFormOptionsWrapperClass!} p-login__formArea--link">
                <#if realm.resetPasswordAllowed>
                    <p class="p-login__formArea--forgetLink">
                        <a tabindex="5" href="https://app.lafool.jp/accounts/password/new">
                            ${msg("doForgotPassword")}<br>
                            <span class="p-login__formArea--forgetLinkEn">${msg("doForgotPasswordSpan")}</span>
                        </a>
                    </p>
                </#if>
            </div>

            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
            <input tabindex="4" class="btn btn-blue" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>

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
        </form>
        </div>
    </#if>
    </div>

    <div class="p-login__messageArea">
        <p class="p-login__messageTitle">InternetExprolerご利用のお客様へ</p>
        <p class="p-login__messageItem">Microsoft社のInternet Explorerのサポート終了（2022年6月16日）に伴い、ラフールサーベイは2022年からInternet Explorerを動作保証対象外としております。詳しくは<a class="p-login__emailLink" target="_blank" rel="noopener noreferrer" href="https://survey.lafool.jp/support/sys_info/171-2/">ヘルプページ</a>をご覧ください。</p>
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
