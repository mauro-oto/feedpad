ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Last 10 channels" do
          table_for Channel.all.order('id desc').limit(10) do
            column("Title")   {|channel| status_tag(channel.name) }
            column("URL")   {|channel| status_tag(channel.url) }
          end
        end
      end
    end

    columns do
      column do
        panel "Last 10 registered users" do
          table_for User.all.order('id desc').limit(10) do
            column("Username")   {|user| status_tag(user.login_name) }
            column("E-mail")   {|user| status_tag(user.email) }
          end
        end
      end
    end
   
  end # content
end
