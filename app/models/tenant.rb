class Tenant < ActiveRecord::Base

  attr_accessible :sub_domain,
                  :amazon_access_key,
                  :amazon_associate_tag,
                  :amazon_secret_key,
                  :bookbyte_auth_token,
                  :bookbyte_base_url,
                  :bookbyte_publisher_id,
                  :bookrenter_base_url,
                  :bookrenter_developer_key,
                  :chegg_aid,
                  :chegg_base_url,
                  :chegg_key,
                  :chegg_password,
                  :chegg_pid,
                  :chegg_sid,
                  :cj_auth_key,
                  :cj_base_url,
                  :cj_website_id,
                  :color,
                  :logo,
                  :title

  def self.find_by_subdomain(subdomain)
    where(:sub_domain => subdomain)[0]
  end

end
