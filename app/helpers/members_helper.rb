module MembersHelper

  def member_activities
    activity_names = @member.activities.map {|activity| activity.name}
    activity_names.join(', ')
  end

  def format_date date
    return t('member.not_contacted') unless !date.nil?
    date.strftime("%d %b. %Y")
  end

  def activities_hint
    return '' unless !member_activities.empty?
    str = I18n.translate('form.activities_hint', name: @member.name)
    "#{str}: #{member_activities} "
  end

  def form_button
    @member.persisted? ? t('form.update') : t('form.create')
  end
end
