class ApplicationController < ActionController::API

  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include ResponseRenderer
  include ActionController::Helpers

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

  # Filters
  before_action :set_locale
  # before_action :cors_set_access_control_headers

  # Handle Rails exceptions with custom method
  # rescue_from Exception, with: :return_500_error

  # Handle Rails 404 error with custom method
  rescue_from ActiveRecord::RecordNotFound, with: :return_404_error

  # Handle Rails Bad Request error with custom method
  rescue_from ActionController::ParameterMissing, with: :return_400_error

  # rescue_from AuthorizationError, with: :return_403_error

  rescue_from Consul::Powerless, with: :return_403_error

  # rescue_from UnknownFileFormat,  with: :unknown_file_format_error

  # Handle Foreign key voilation error with custom json response
  rescue_from ActiveRecord::InvalidForeignKey do
    render json: { success: false,
                    error: I18n.t('base.invalid_foreign_key'),
                    status_code: 404 }, status: :not_found
  end

  # Handle Range Error with custom method
  rescue_from RangeError, with: :return_range_error

  # Handle Mustache::Parser::SyntaxError
  # rescue_from Mustache::Parser::SyntaxError do
  #   render_unprocessable_entity(message: I18n.t('letter_request.e_invalid_template'))
  # end


  # Handle exceptions
  # rescue_from Exception do |e|
  #   render json: { success: false,
  #                  error: e.message,
  #                  status_code: 500 },
  #               status: 500
  # end


  # Action to follow routes with HTTP verb 'OPTIONS'
  # def cors
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
  #   headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token, Content-Type, Access-Token, slug, locale, authorization'
  #   headers['Access-Control-Max-Age'] = '1728000'

  #   render text: '', content_type: 'text/plain'
  # end


  protected

    # This method will set the locale to the one passed in the querystring to 'locale' param
    def set_locale
      locale = params[:locale] || request.headers['locale']
      I18n.locale = locale.present? ? locale : I18n.default_locale
    end

    # This method will return JSON error message with 500 status code when rails app
    # throw Internal Server Error.
    def return_500_error
      render json: { success: false, error: I18n.t('errors.e_500'),
                    status_code: 500 }, status: :internal_server_error
    end

    # This method will return JSON error message with 404 status code when rails app
    # throw not found error.
    def return_404_error
      render json: { success: false, error: I18n.t('errors.e_404'),
                    status_code: 404 }, status: :not_found
    end

    # This method will return JSON error message with 400 status code when rails app
    # throw bad request error.
    def return_400_error
      render json: { success: false, error: I18n.t('errors.e_400'),
                    status_code: 400 }, status: 400
    end

    def return_403_error
      render json: { success: false, error: I18n.t('errors.e_403'),
                    status_code: 403 }, status: 403
    end

    # This method will return JSON error message with 400 status code when rails app
    # throw range error.
    def return_range_error
      render json: { success: false, error: I18n.t('errors.e_range_error'),
                    status_code: 400 }, status: 400
    end

    # def unknown_file_format_error
    #   render json: { success: false, error: I18n.t("bulk_import.unknown_file_type"),
    #                 status_code: 422 }, status: 422
    # end

    # This method will set the access control header accordingly after each action performed.
    # def cors_set_access_control_headers
    #   headers['Access-Control-Allow-Origin'] = '*'
    #   headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    #   headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Access-Token, slug, locale, authorization'
    #   headers['Access-Control-Max-Age'] = "1728000"
    # end
end
