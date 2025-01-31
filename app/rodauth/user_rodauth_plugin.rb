require "sequel/core"

class UserRodauthPlugin < RodauthPlugin
  configure do
    # This block is running inside of
    #   plugin :rodauth do
    #     ...
    #   end

    # ==> Features
    # See the Rodauth documentation for the list of available config options:
    # http://rodauth.jeremyevans.net/documentation.html

    # List of authentication features that are loaded.
    enable :login, :remember, :logout, :create_account, :verify_account,
      :verify_account_grace_period, :reset_password,
      :reset_password_notify, :change_login, :verify_login_change,
      :change_password, :change_password_notify, :case_insensitive_login,
      :internal_request

    # ==> General

    # Prevent rodauth from introspecting the database if we are not using UUIDs
    convert_token_id_to_integer? { User.columns_hash["id"].type == :integer }

    # Change prefix of table and foreign key column names from default "account"
    accounts_table :users
    remember_table :user_remember_keys
    reset_password_table :user_password_reset_keys
    verify_account_table :user_verification_keys
    verify_login_change_table :user_login_change_keys

    # The secret key used for hashing public-facing tokens for various features.
    # Defaults to Rails `secret_key_base`, but you can use your own secret key.
    # hmac_secret "<SECRET_KEY>"

    # Use path prefix for all routes.
    prefix "/auth"

    # Store password hash in a column instead of a separate table.
    account_password_hash_column :password_hash

    # Specify the controller used for view rendering, CSRF, and callbacks.
    rails_controller { Rodauth::UserController }

    # Specify the model to be used.
    rails_account_model { User }

    # Set password password during create account.
    # verify_account_set_password? false

    # Change some default param keys.
    # login_param "email"
    # password_confirm_param "confirm_password"

    # Redirect back to originally requested location after authentication.
    login_return_to_requested_location? true
    # two_factor_auth_return_to_requested_location? true # if using MFA

    # Autologin the user after they have reset their password.
    # reset_password_autologin? true

    # Delete the account record when the user has closed their account.
    # delete_account_on_close? true

    # Redirect to the app from login and registration pages if already logged in.
    # already_logged_in { redirect login_redirect }

    # Accept both api and form requests
    # Requires the JSON feature
    # only_json? false

    # ==> Emails
    # Use a custom mailer for delivering authentication emails.

    create_reset_password_email do
      Rodauth::UserMailer.reset_password(self.class.configuration_name,
                                         account_id, reset_password_key_value)
    end

    create_verify_account_email do
      Rodauth::UserMailer.verify_account(self.class.configuration_name,
                                         account_id, verify_account_key_value)
    end

    create_verify_login_change_email do |_login|
      Rodauth::UserMailer.verify_login_change(self.class.configuration_name,
                                              account_id, verify_login_change_key_value)
    end

    create_password_changed_email do
      Rodauth::UserMailer.change_password_notify(self.class.configuration_name,
                                                 account_id)
    end

    create_reset_password_notify_email do
      Rodauth::UserMailer.reset_password_notify(self.class.configuration_name,
                                                account_id)
    end

    send_email do |email|
      # queue email delivery on the mailer after the transaction commits
      db.after_commit { email.deliver_later }
    end

    # ==> Flash
    # Does not work with only_json?

    # Match flash keys with ones already used in the Rails app.
    # flash_notice_key :success # default is :notice
    # flash_error_key :error # default is :alert

    # Override default flash messages.
    # create_account_notice_flash "Your account has been created. Please verify your account by visiting the confirmation link sent to your email address."
    # require_login_error_flash "Login is required for accessing this page"
    # login_notice_flash nil

    # ==> Validation
    # Override default validation error messages.
    # no_matching_login_message "user with this email address doesn't exist"
    # already_an_account_with_this_login_message "user with this email address already exists"
    # password_too_short_message { "needs to have at least #{password_minimum_length} characters" }
    # login_does_not_meet_requirements_message { "invalid email#{", #{login_requirement_message}" if login_requirement_message}" }

    # ==> Passwords

    # Passwords shorter than 8 characters are considered weak according to OWASP.
    password_minimum_length 8

    # Custom password complexity requirements (alternative to password_complexity feature).
    # password_meets_requirements? do |password|
    #   super(password) && password_complex_enough?(password)
    # end
    # auth_class_eval do
    #   def password_complex_enough?(password)
    #     return true if password.match?(/\d/) && password.match?(/[^a-zA-Z\d]/)
    #     set_password_requirement_error_message(:password_simple, "requires one number and one special character")
    #     false
    #   end
    # end

    # = bcrypt

    # bcrypt has a maximum input length of 72 bytes, truncating any extra bytes.
    password_maximum_bytes 72 if respond_to?(:password_maximum_bytes)

    # ==> Remember Feature

    # Remember all logged in users.
    after_login { remember_login }

    # Or only remember users that have ticked a "Remember Me" checkbox on login.
    # after_login { remember_login if param_or_nil("remember") }

    # Extend user's remember period when remembered via a cookie
    extend_remember_deadline? true

    # Store the user's remember cookie under a namespace
    remember_cookie_key "_user_remember"

    # ==> Hooks

    # Validate custom fields in the create account form.
    # before_create_account do
    #   throw_error_status(422, "name", "must be present") if param("name").empty?
    # end

    # Perform additional actions after the account is created.
    # after_create_account do
    #   Profile.create!(account_id: account_id, name: param("name"))
    # end

    # Do additional cleanup after the account is closed.
    # after_close_account do
    #   Profile.find_by!(account_id: account_id).destroy
    # end

    # ==> Redirects

    # Redirect to home after login.
    create_account_redirect "/"

    # Redirect to home after login.
    login_redirect "/"

    # Redirect to home page after logout.
    logout_redirect "/auth/login"

    # Redirect to wherever login redirects to after account verification.
    verify_account_redirect { login_redirect }

    # Redirect to login page after password reset.
    reset_password_redirect { login_path }

    # ==> Deadlines
    # Change default deadlines for some actions.
    # verify_account_grace_period 3.days.to_i
    # reset_password_deadline_interval Hash[hours: 6]
    # verify_login_change_deadline_interval Hash[days: 2]
    # remember_deadline_interval Hash[days: 30]
  end
end
