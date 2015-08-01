module AccountsHelper
  def show_cooperative_header?
    user_signed_in? && !current_user.cooperative_id.nil?
  end
end
