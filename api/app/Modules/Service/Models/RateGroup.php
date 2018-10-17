<?php

namespace App\Modules\Service\Models;

use Illuminate\Database\Eloquent\Model;

class RateGroup extends Model
{
    protected $fillable = [
        'name', 'description'
    ];
}
