<?php

namespace App\Http\Controllers;

use App\Services\UserService;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public function __construct(private UserService $service)
    {

    }

    public function index(Request $request)
    {
        return $this->service->all();
    }

    public function store(Request $request)
    {
        $data = $request->all();
        return $this->service->create($data);
    }

    public function show($id)
    {
        return $this->service->find($id);
    }

    public function update(Request $request, $id)
    {
        $data = $request->all();
        return $this->service->update($id, $data);
    }

    public function destroy($id)
    {
        return $this->service->delete($id);
    }
}
