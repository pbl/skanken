module AccountsHelper

  def format_user_roles(role)
    return t('accounts.cooperative_admin') if role.eql?('cooperative_admin')
    return t('accounts.foreman') if role.eql?('foreman')
    raise "error"
  end
end
