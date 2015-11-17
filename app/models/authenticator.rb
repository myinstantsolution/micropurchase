class Authenticator < Struct.new(:auth_hash, :session)
  attr_reader :user

  def perform
    find_or_create_user
    update_user
    sign_in
    redirect_hash
  end

  private

  def find_or_create_user
    @user = found_user || created_user
  end

  def update_user
    user.update_attributes({
      name: name
    })
  end

  def sign_in
    session[:user_id] = user.id
  end

  def redirect_hash
    # protects redirects as outlined here:
    # http://brakemanscanner.org/docs/warning_types/redirect/
    index_hash = {
      controller: :auctions,
      action: :index,
      only_path: true
    }
    edit_users_hash = {
      controller: :users,
      action: :edit,
      id: user.id,
      only_path: true
    }

    admin? ? index_hash : edit_users_hash
  end

  def found_user
    User.where(github_id: github_id).first
  end

  def created_user
    User.create(github_id: github_id)
  end

  def admin?
    Admins.verify?(github_id)
  end

  # parser

  def github_id
    auth_hash[:uid]
  end

  def name
    auth_hash[:info] && auth_hash[:info][:name]
  end
end
