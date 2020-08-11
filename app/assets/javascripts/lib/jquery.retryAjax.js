(function($) {
	$.retryAjax = function(ajaxParams) {
		var errorCallback;
		ajaxParams.tryCount = !ajaxParams.tryCount ? 0 : ajaxParams.tryCount;
		ajaxParams.retryLimit = !ajaxParams.retryLimit ? 2 : ajaxParams.retryLimit;
		ajaxParams.retryInterval = !ajaxParams.retryInterval ? 1000 : ajaxParams.retryInterval;

		ajaxParams.suppressErrors = true;

		if (ajaxParams.error) {
			errorCallback = ajaxParams.error;
			delete ajaxParams.error;
		} else {
			errorCallback = function() {};
		}

		ajaxParams.complete = function(jqXHR, textStatus) {
			if ($.inArray(textStatus, ['timeout', 'abort', 'error']) > -1) {
				this.tryCount++;
				if (this.tryCount <= this.retryLimit) {
					// Fire error handling on the last try
					if (this.tryCount === this.retryLimit) {
						this.error = errorCallback;
						delete this.suppressErrors;
					}

					// Try again
					setTimeout(
						function() {
							console.log(this.tryCount);
							$.ajax(this);
						}.bind(this),
						this.retryInterval
					);

					return true;
				}

				window.alert('There was a server error.  Please refresh the page.  If the issue persists, give us a call. Thanks!');
				return true;
			}
		};

		$.ajax(ajaxParams);
	};
})(jQuery);
