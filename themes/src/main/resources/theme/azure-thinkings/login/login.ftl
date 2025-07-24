<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <p class="p-login__formArea--text">１つのアカウント情報で複数の契約サービスにログインできます</p>
    <p class="p-login__formArea--description">ご契約されていないサービスの料金は発生しません<br>採用適性検査「テキカク」の導入をご検討の方は<br class="sp_show"><a href="https://survey.lafool.jp/tekikaku-contact/" target="_blank">お問い合わせ</a>ください</p>
    <div class="p-login__formAreaInner">
    <ul class="p-login__formArea--logo">
        <li class="p-login__formArea--logo_survey">
            <img alt="ラフールサーベイ" src="${url.resourcesPath}/img/logo_survey_mono.svg">
        </li>
        <li class="p-login__formArea--logo_tekikaku">
            <img alt="テキカク" src="${url.resourcesPath}/img/logo_tekikaku_mono.svg">
        </li>
    </ul>
    </div>

    <div class="p-login__messageArea">
        <p class="p-login__messageTitle">InternetExprolerご利用のお客様へ</p>
        <p class="p-login__messageItem">Microsoft社のInternet Explorerのサポート終了（2022年6月16日）に伴い、ラフールサーベイは2022年からInternet Explorerを動作保証対象外としております。詳しくは<a class="p-login__emailLink" target="_blank" rel="noopener noreferrer" href="https://survey.lafool.jp/support/sys_info/171-2/">ヘルプページ</a>をご覧ください。</p>
    </div>
    <p class="text-center" id="browser_message"></p>

    <#list social.providers as p>
        <#if p.alias == "thinkings">
	<div class="p-login__formArea--form">
            <a id="social-${p.alias}" class="btn btn-microsoft" type="button" href="${p.loginUrl}">
		<img alt="マイクロソフト" src="${url.resourcesPath}/img/icon_microsoft.png" class="btn-icon">
                <span>${p.displayName!}</span>
            </a>
	</div>
        </#if>
    </#list>
</@layout.registrationLayout>
