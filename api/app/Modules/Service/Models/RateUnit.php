<?php

namespace App\Modules\Service\Models;

use Illuminate\Auth\Authenticatable;
use Illuminate\Database\Eloquent\SoftDeletes;
use Laravel\Lumen\Auth\Authorizable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;

class RateUnit extends Model
{
    use SoftDeletes;

    protected $fillable = [
        'unit', 'factor', 'archived'
    ];

    protected $cast = [
        'factor' => 'double'
    ];
}
