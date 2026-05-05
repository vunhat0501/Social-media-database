import { IsString, IsOptional, IsArray, ValidateNested, IsIn, IsNumber } from 'class-validator';
import { Type } from 'class-transformer';

export class PostMediaDto {
  @IsString()
  mediaUrl: string;

  @IsString()
  @IsOptional()
  @IsIn(['image', 'video'])
  mediaType?: string;

  @IsNumber()
  @IsOptional()
  sequenceOrder?: number;
}

export class CreatePostDto {
  @IsString()
  @IsOptional()
  title?: string;

  @IsString()
  @IsOptional()
  @IsIn(['public', 'private', 'friends'])
  status?: string;

  @IsString()
  @IsOptional()
  location?: string;

  @IsArray()
  @IsOptional()
  @ValidateNested({ each: true })
  @Type(() => PostMediaDto)
  media?: PostMediaDto[];

  @IsArray()
  @IsString({ each: true })
  @IsOptional()
  hashtags?: string[];
}
