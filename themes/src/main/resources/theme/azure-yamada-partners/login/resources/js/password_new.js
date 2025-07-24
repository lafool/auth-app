const A = (function() {
	var _elems, _methods, _vars;
	_elems = {};
	_vars = {};
	_methods = {
        onClickAccountPasswordResetBtn: function() {
            return _elems.passwordSubmit.on('click', function(e) {
                var formData;
                e.preventDefault();
                _elems.fieldWithErrors.hide();
                formData = {};
                formData.passwordField = _elems.passwordField.val();
                if (!formData.passwordField.match(/^[-a-z0-9~!$%^&*_=+{}\'?]+(\.[-a-z0-9~!$%^&*_=+{}\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(jpxxx|tokyo|aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i)) {
                    _elems.fieldError.show();
                    return;
                }
                return _elems.passwordForm.submit();
            });
        },
        enterKeyDisable: function() {
            return _elems.passwordField.keydown(function(e) {
                return !(e.which && e.which === 13 || e.keyCode && e.keyCode === 13);
            });
        }
    };
    return {
        init: function() {
            this.setElements();
            return this.attachListeners();
        },
        setElements: function() {
            _elems.fieldError = $('.js-fieldError');
            _elems.passwordField = $('.js-passwordField');
            _elems.passwordSubmit = $('.js-passwordSubmit');
            _elems.passwordForm = $('.js-passwordForm');
            return _elems.fieldWithErrors = $('.field_with_errors');
        },
        attachListeners: function() {
            _methods.onClickAccountPasswordResetBtn();
            return _methods.enterKeyDisable();
        }
    };
})();

$(function(){
    A.init();
});
