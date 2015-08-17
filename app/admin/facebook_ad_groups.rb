ActiveAdmin.register_page "FacebookAdGroups" do

  menu priority: 1, label: "FacebookAdGp"

  content title: "Facebook Ads Data" do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span "ds"
    #     small "dsd"
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         FbAd.all.last(5).map do |post|
    #           li link_to(post.adid, "/")
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

  table_for FbAd.where("urldomain = 'https://viralstyle' AND t_spend > 0").map do
    column "Adid",     :adid
    column "t_spend",  :t_spend
    column "tot_spend",:tot_spend
    column "urldomain",:urldomain do |o|
      o.urldomain.split(":").first
    end
    column "urlcode",  :urlcode
    column "created_at", :created_at
  end

  end # content


end

