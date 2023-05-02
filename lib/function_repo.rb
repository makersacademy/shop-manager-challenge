require_relative './function'

class FunctionRepo
  def all
    functions = []

    sql = 'SELECT * FROM shop_functions;'
    results = DatabaseConnection.exec_params(sql, [])

    results.each do |result|
      function = Function.new

      function.id = result['id']
      function.function = result['function']

      functions << function
    end

    return functions
  end
end
