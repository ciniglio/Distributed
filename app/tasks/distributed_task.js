var distributed_task_id = <%= @task.id %>

<% if @task.parameters %>
distributed_paramters = <%= @task.parameters %>;
<% end %>

<%= render file:@task.filename %>
