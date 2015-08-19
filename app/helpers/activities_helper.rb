module ActivitiesHelper
  def activated_row_class activated
    return 'danger' unless activated
    ''
  end

  def deactivate_link activated
    return t('activities.activate')  unless activated
    t('activities.deactivate')
  end

  def destroy_link(record)
    return '' unless record.members.empty?
    (link_to t('common.delete'), activity_path(record),
  method: :delete, data: { confirm: t('activities.confirm_destroy') }).html_safe
  end
end
