import {
  IsEmail,
  IsNotEmpty,
  IsString,
  MaxLength,
  MinLength,
} from 'class-validator';

export class CreateUserDto {
  @IsString()
  @IsNotEmpty()
  @MinLength(2)
  @MaxLength(20)
  userName: string;

  @IsEmail({}, { message: 'Invalid email' })
  @IsNotEmpty()
  email: string;
}
