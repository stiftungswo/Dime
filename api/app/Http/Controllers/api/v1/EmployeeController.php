<?php

namespace App\Http\Controllers\Api\V1;

use App\Modules\Employee\Models\Employee;
use Illuminate\Support\Facades\Input;
use Laravel\Lumen\Routing\Controller;

class EmployeeController extends Controller
{

    public function index()
    {
        return Employee::all();
    }

    public function post()
    {
        Employee::create(Input::toArray());
    }

    public function put($id)
    {
        Employee::findOrFail($id)->update(Input::toArray());
    }

    public function delete($id)
    {
        Employee::findOrFail($id)->delete();
    }
}
