module ResponseRenderer
    extend ActiveSupport::Concern

    def render_success(message: nil, data: nil, status_code: 200)
      render(
        json: {success: true, message: message, data: data},
        status: status_code
      )
    end

    def render_error(message: I18n.t('errors.e_400'), status_code: 400)
      render(
        json: {success: false, error: message},
        status: status_code
      )
    end

    def render_500_error(message: I18n.t('errors.e_500'))
      render_error(
        message: message,
        status_code: 500
      )
    end

    def render_bad_request(message: I18n.t('errors.e_400'))
      render_error(
        message: message,
        status_code: 400
      )
    end

    def render_unprocessable_entity(message: I18n.t('errors.e_422'))
      render_error(
        message: message,
        status_code: 422
      )
    end

    def render_unauthorized(message: I18n.t('errors.e_401'))
      render_error(
        message: message,
        status_code: 401
      )
    end

    def render_not_found(message: I18n.t('errors.e_404'))
      render_error(
        message: message,
        status_code: 404
      )
    end

    def render_forbidden(message: I18n.t('errors.e_403'))
      render_error(
        message: message,
        status_code: 403
      )
    end

    def render_empty(root: 'collection', message: nil)
      render_success(
        message: message,
        data: {count: 0, root.to_sym => []}
      )
    end

    def render_created(message: nil, data: nil)
      message ||= created_message
      render_success(
        message: message,
        data: data,
        status_code: 201
      )
    end

    def created_message(name = nil)
      I18n.t(
        'resource.created',
        name: name || resource_class.model_name.human
      )
    end

    def updated_message(name = nil)
      I18n.t(
        'resource.updated',
        name: name || resource_class.model_name.human
      )
    end

    def destroyed_message(name = nil)
      I18n.t(
        'resource.deleted',
        name: name || resource_class.model_name.human
      )
    end
  end
