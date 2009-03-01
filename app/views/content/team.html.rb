<div id="team">
  <h1><a href="/">SimplyDo.com</a> is brought to you by ...</h1>
  <% for team_member in %w(daniel alex).sort_by { rand } %>
    <%= render :partial => "content/#{team_member}" %>
  <% end %>
  <div class="clearThis"> </div>
</div>