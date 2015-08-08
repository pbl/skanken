module ActivitiesHelper
  def activated_row_class activated
    return 'danger' unless activated
    ''
  end

  def deactivate_link activated
    return t('activities.activate')  unless activated
    t('activities.deactivate')
  end
end
