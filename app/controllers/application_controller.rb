class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    search_index_path
  end

  def get_tenant_params
    tenant = Tenant.find_by_subdomain request.subdomain

    params[:amazon_access_key] = tenant.amazon_access_key
    params[:amazon_secret_key] = tenant.amazon_secret_key
    params[:amazon_associate_tag] = tenant.amazon_associate_tag
    params[:bookbyte_base_url] = tenant.bookbyte_base_url
    params[:bookbyte_auth_token] = tenant.bookbyte_auth_token
    params[:bookbyte_publisher_id] = tenant.bookbyte_publisher_id
    params[:cj_website_id] = tenant.cj_website_id
    params[:cj_auth_key] = tenant.cj_auth_key
    params[:cj_base_url] = tenant.cj_base_url
    params[:bookrenter_base_url] = tenant.bookrenter_base_url
    params[:bookrenter_developer_key] = tenant.bookrenter_developer_key
    params[:chegg_base_url] = tenant.chegg_base_url
    params[:chegg_password] = tenant.chegg_password
    params[:chegg_key] = tenant.chegg_key
    params[:chegg_aid] = tenant.chegg_aid
    params[:chegg_pid] = tenant.chegg_pid
    params[:chegg_sid] = tenant.chegg_sid
    params[:sub_domain] = tenant.sub_domain

    params

  end

  private

  def current_tenant
     Tenant.find_by_subdomain request.subdomain
  end
  helper_method :current_tenant

end
