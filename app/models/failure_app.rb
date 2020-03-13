class FailureApp < Devise::FailureApp
  def http_auth_body
    return super unless request_format == :json

    {
      type: warden_message || 'unauthorized',
      message: i18n_message
    }.to_json
  end
end
