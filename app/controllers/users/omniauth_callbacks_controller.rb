class Users::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  def get_resource_from_auth_hash
    # find or create user by provider and provider uid
    @resource = resource_class.where({
                                         uid:      auth_hash['uid'],
                                         provider: auth_hash['provider']
                                     }).first_or_initialize

    if @resource.new_record?
      @resource.google_tokens = auth_hash['credentials'].to_json # ONLY FOR GOOGLE OAUTH
      @oauth_registration = true
      set_random_password
    end

    # sync user info with provider, update/generate auth token
    assign_provider_attrs(@resource, auth_hash)

    # assign any additional (whitelisted) attributes
    extra_params = whitelisted_params
    @resource.assign_attributes(extra_params) if extra_params

    @resource
  end
end
