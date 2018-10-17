<?php

namespace App\Modules\Employee\Models;

use Illuminate\Auth\Authenticatable;
use Illuminate\Database\Eloquent\SoftDeletes;
use Laravel\Lumen\Auth\Authorizable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Contracts\Auth\Authenticatable as AuthenticatableContract;
use Illuminate\Contracts\Auth\Access\Authorizable as AuthorizableContract;

class Employee extends Model implements AuthenticatableContract, AuthorizableContract
{
    use Authenticatable, Authorizable, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'is_admin', 'email', 'first_name', 'last_name', 'can_login', 'archived', 'holidays_per_year', 'deleted_at', 'password'
    ];

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = [
        'password',
    ];

    /**
     * Probably casts attributes to the given data type
     * @var array $casts
     */
    protected $casts = [
        'archived' => 'boolean',
        'can_login' => 'boolean',
        'is_admin' => 'boolean'
    ];

    public function setPasswordAttribute($value)
    {
        if (!$value) {
            return;
        }

        $this->attributes['password'] = app('hash')->make($value);
    }
}
