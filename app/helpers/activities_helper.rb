module ActivitiesHelper
  def destroy_link(record)
    return '' unless record.members.empty?
    (link_to t('common.delete'), activity_path(record),
  method: :delete, data: { confirm: t('activities.confirm_destroy') }).html_safe
  end
end
