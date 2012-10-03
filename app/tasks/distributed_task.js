var distributed_task_id = <%= @task.id %>;

<% if @task.parameters %>
distributed_parameters = <%= raw @task.parameters %>;
<% end %>

<%= render file:@task.filename %>
