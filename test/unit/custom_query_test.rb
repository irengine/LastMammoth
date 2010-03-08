require 'test_helper'

class CustomQueryTest < ActiveSupport::TestCase
  fixtures :custom_queries, :custom_query_parameters, :custom_query_columns

  test "the truth" do
    assert true
  end

  test "load yml data" do
    assert_equal 2, custom_queries("employee_query").parameters.length
    assert_equal 2, custom_queries("employee_query").columns.length
  end

  test "generate sql" do
    where_clause = custom_queries("employee_query").syntax
    where_clause << " where "
    where_clause << custom_queries("employee_query").parameters.collect {|p| p.syntax}.join(" and ")
    conditions = [where_clause]
    conditions << "2"
    conditions << 50

    sql = "select "
    sql << custom_queries("employee_query").columns.collect {|c| c.name}.join(', ')
    sql << " "
    sql << ActiveRecord::Base.send(:sanitize_sql_array, conditions)

    puts sql

    @result = ActiveRecord::Base.connection.execute(sql)
  end

  test "generate view" do
    q = custom_queries("employee_query")
    puts CustomQueryGenerator.view_for(q)
  end

  test "generate query" do
    values = {"Employee__name"=>"", "Employee__age"=>"1"};
    q = custom_queries("employee_query")
    puts CustomQueryGenerator.sql_for(q, values)
  end
end
